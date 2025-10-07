/*

/*
 *
 *  mysizex   :   local x-extendion of your patch
 *  mysizey   :   local y-extension of your patch
 *
 */

#include "../include/stencil_template_parallel.h"
#include <immintrin.h>

// ------------------------------------------------------------------
// ------------------------------------------------------------------

int main(int argc, char **argv)
{
  MPI_Comm myCOMM_WORLD; // communicator
  int Rank, Ntasks;      // my rank and the total number of MPI tasks
  uint neighbours[4];    // my neighbours in the order {N, S, E, W}

  int Niterations; // how many iterations to perform
  int periodic;    // whether periodic boundary conditions apply
  vec2_t S, N;     // the size of the plate and the grid of MPI tasks

  int Nsources;             // total number of sources
  int Nsources_local;       // number of sources in the local patch
  vec2_t *Sources_local;    // local sources
  double energy_per_source; // how much energy per source

  plane_t planes[2];    // two planes, one for the old data and one for the new data
  buffers_t buffers[2]; // communication buffers

  int output_energy_stat_perstep;

  /* initialize MPI envrionment */
  {
    int level_obtained;

    // NOTE: change MPI_FUNNELED if appropriate
    //
    // MPI_THREAD_FUNNELED: the process may be multi-threaded but only the main 
    // thread will make MPI calls (this is the default level of thread support)

    MPI_Init_thread(&argc, &argv, MPI_THREAD_FUNNELED, &level_obtained); 
    if (level_obtained < MPI_THREAD_FUNNELED)
    {
      printf("MPI_thread level obtained is %d instead of %d\n",
             level_obtained, MPI_THREAD_FUNNELED);
      MPI_Finalize();
      exit(1);
    }

    MPI_Comm_rank(MPI_COMM_WORLD, &Rank);   // get the rank
    MPI_Comm_size(MPI_COMM_WORLD, &Ntasks); // get the number of tasks
    MPI_Comm_dup(MPI_COMM_WORLD, &myCOMM_WORLD);  
  }

  /* argument checking and setting */
  int ret = initialize(&myCOMM_WORLD, Rank, Ntasks, argc, argv, &S, &N, &periodic, &output_energy_stat_perstep,
                       neighbours, &Niterations,
                       &Nsources, &Nsources_local, &Sources_local, &energy_per_source,
                       &planes[0], &buffers[0]);

  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  printf("task %d is initialized\n", Rank);
  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  if (ret)
  {
    printf("task %d is opting out with termination code %d\n",
           Rank, ret);

    MPI_Finalize();
    return 0;
  }

  int current = OLD;
  double comm_time = 0, inject_time = 0, wait_time = 0, fill_buff_time = 0, copy_halo_time = 0, update_time = 0;
  
  MPI_Barrier(myCOMM_WORLD); // synchronize all processes
  double t0 = MPI_Wtime(); // start wall timing

  for (int iter = 0; iter < Niterations; ++iter)
  {
    MPI_Request reqs[8];

    for (int i = 0; i < 8; i++)
      reqs[i] = MPI_REQUEST_NULL;

    // inject new energy from sources
    double t_inject_1 = MPI_Wtime();
    inject_energy(periodic, Nsources_local, Sources_local, energy_per_source, &planes[current], N);
    double t_inject_2 = MPI_Wtime();

    // [A] fill the buffers, and/or make the buffers' pointers pointing to the correct position

    double t_fill_buff_1 = MPI_Wtime();
    fill_buffers(&planes[current], neighbours, N, buffers, periodic);
    double t_fill_buff_2 = MPI_Wtime();

    // [B] perfoem the halo communications
    //     (1) use Send / Recv
    //     (2) use Isend / Irecv
    //         --> can you overlap communication and compution in this way?

    double t_comm_1 = MPI_Wtime();
    halo_communications(&planes[current], neighbours, buffers, &myCOMM_WORLD, reqs);
    double t_comm_2 = MPI_Wtime();

    // Compute update of the interior points here
    double t_0 = MPI_Wtime();
    update_inner_points(&planes[current], &planes[!current]);
    double t_1 = MPI_Wtime();

    double t_wait_1 = MPI_Wtime();
    MPI_Waitall(8, reqs, MPI_STATUSES_IGNORE);
    double t_wait_2 = MPI_Wtime();

    // [C] copy the haloes data
    double t_copy_halo_1 = MPI_Wtime();
    copy_halo(&planes[current], neighbours, N, buffers, periodic);
    double t_copy_halo_2 = MPI_Wtime();

    /* --------------------------------------  */
    /* update grid points */
    double t_2 = MPI_Wtime();
    update_boundary_points(&planes[current], &planes[!current], periodic, N);
    double t_3 = MPI_Wtime();

    /* output if needed */
    /* if (output_energy_stat_perstep)
      output_energy_stat(iter, &planes[!current], (iter + 1) * Nsources * energy_per_source, Rank, &myCOMM_WORLD);

    char filename[100];
    sprintf(filename, "./data_parallel/%d_plane_%05d.bin", Rank, iter);
    int dump_status = dump(planes[!current].data, planes[!current].size, filename);
    if (dump_status != 0)
    {
      fprintf(stderr, "Error in dump_status. Exit with %d\n", dump_status);
    } */

    /* swap plane indexes for the new iteration */

    comm_time += (t_comm_2 - t_comm_1);
    inject_time += (t_inject_2 - t_inject_1);
    wait_time += (t_wait_2 - t_wait_1);
    fill_buff_time += (t_fill_buff_2 - t_fill_buff_1);
    copy_halo_time += (t_copy_halo_2 - t_copy_halo_1);
    update_time += (t_1 - t_0) + (t_3 - t_2);

    current = !current;
  }

  printf("Rank %d :: inject time is %.6f, fill buffer time is %.6f, communication time is %.6f, wait time is %.6f, copy halo time is %.6f, update planes time is %.6f\n",
         Rank, inject_time, fill_buff_time, comm_time, wait_time, copy_halo_time, update_time);

  t0 = MPI_Wtime() - t0;
  printf("---------Rank: %d \t Elapsed time:%.6f---------\n", Rank, t0);

  output_energy_stat(-1, &planes[!current], Niterations * Nsources * energy_per_source, Rank, &myCOMM_WORLD);

  memory_release(planes, buffers);

  double comms_sum = 0.0;
  double comp_time = 0.0;
  MPI_Reduce(&comm_time, &comms_sum, 1, MPI_DOUBLE, MPI_SUM, 0, myCOMM_WORLD);
  MPI_Reduce(&t0, &comp_time, 1, MPI_DOUBLE, MPI_SUM, 0, myCOMM_WORLD);

  if (Rank == 0)
  {
    int P;
    MPI_Comm_size(myCOMM_WORLD, &P);
    printf("Comp time,Comms time\n");
    printf("%.6f,%.6f\n\n", comp_time / (double)P, comms_sum / (double)P);
  }

  MPI_Finalize();
  return 0;
}

/* ==========================================================================
   =                                                                        =
   =   routines called within the integration loop                          =
   ========================================================================== */

/* ==========================================================================
   =                                                                        =
   =   initialization                                                       =
   ========================================================================== */

uint simple_factorization(uint, int *, uint **);

// ----------------------------------------------------------------------------------------------------------------------------------
// A
void fill_buffers(plane_t *plane, int *neighbours, vec2_t N, buffers_t *buffers, int periodic)
{
  const uint xsize = plane->size[_x_];
  const uint ysize = plane->size[_y_];
  const uint fsize = xsize + 2;

#define IDX(i, j) ((j) * fsize + (i))

  // If a neighbor exists in this direction:
  //   - prepare SEND buffer → point to the boundary row/column of my data
  //   - prepare RECV buffer → point to the ghost row/column where neighbor's data will be stored

  if (neighbours[NORTH] != MPI_PROC_NULL)
  {
    buffers[SEND][NORTH] = &plane->data[IDX(1, 1)]; // first row of the computational domain
    buffers[RECV][NORTH] = &plane->data[IDX(1, 0)]; // first ghost row
  }

  if (neighbours[SOUTH] != MPI_PROC_NULL)
  {
    buffers[SEND][SOUTH] = &plane->data[IDX(1, ysize)];     // last row of the computational domain
    buffers[RECV][SOUTH] = &plane->data[IDX(1, ysize + 1)]; // last ghost row
  }

  // receive in part C
  if (neighbours[EAST] != MPI_PROC_NULL)
  {
    for (uint i = 0; i < ysize; i++)
    {
      buffers[SEND][EAST][i] = plane->data[IDX(xsize, i + 1)];
    }
  }

  if (neighbours[WEST] != MPI_PROC_NULL)
  {
    for (uint i = 0; i < ysize; i++)
    {
      buffers[SEND][WEST][i] = plane->data[IDX(1, i + 1)];
    }
  }

#undef IDX
}

// ----------------------------------------------------------------------------------------------------------------------------------
// B

void halo_communications(plane_t *plane, int *neighbours, buffers_t *buffers, MPI_Comm *myCOMM_WORLD, MPI_Request *reqs)
{
  const uint xsize = plane->size[_x_];
  const uint ysize = plane->size[_y_];

  // to check if tags are correctly matched

  if (neighbours[NORTH] != MPI_PROC_NULL)
  {
    MPI_Irecv(buffers[RECV][NORTH], xsize, MPI_DOUBLE, neighbours[NORTH], 0, *myCOMM_WORLD, &reqs[0]);
    MPI_Isend(buffers[SEND][NORTH], xsize, MPI_DOUBLE, neighbours[NORTH], 1, *myCOMM_WORLD, &reqs[1]);
  }

  if (neighbours[SOUTH] != MPI_PROC_NULL)
  {
    MPI_Irecv(buffers[RECV][SOUTH], xsize, MPI_DOUBLE, neighbours[SOUTH], 1, *myCOMM_WORLD, &reqs[2]);
    MPI_Isend(buffers[SEND][SOUTH], xsize, MPI_DOUBLE, neighbours[SOUTH], 0, *myCOMM_WORLD, &reqs[3]);
  }

  if (neighbours[EAST] != MPI_PROC_NULL)
  {
    MPI_Irecv(buffers[RECV][EAST], ysize, MPI_DOUBLE, neighbours[EAST], 2, *myCOMM_WORLD, &reqs[4]);
    MPI_Isend(buffers[SEND][EAST], ysize, MPI_DOUBLE, neighbours[EAST], 3, *myCOMM_WORLD, &reqs[5]);
  }

  if (neighbours[WEST] != MPI_PROC_NULL)
  {
    MPI_Irecv(buffers[RECV][WEST], ysize, MPI_DOUBLE, neighbours[WEST], 3, *myCOMM_WORLD, &reqs[6]);
    MPI_Isend(buffers[SEND][WEST], ysize, MPI_DOUBLE, neighbours[WEST], 2, *myCOMM_WORLD, &reqs[7]);
  }
}

// ----------------------------------------------------------------------------------------------------------------------------------
// C
void copy_halo(plane_t *plane, int *neighbours, vec2_t N, buffers_t *buffers, int periodic)
{

  const uint xsize = plane->size[_x_];
  const uint ysize = plane->size[_y_];
  const uint fsize = xsize + 2;

#define IDX(i, j) ((j) * fsize + (i))

  if (neighbours[EAST] != MPI_PROC_NULL)
  {
    for (uint i = 0; i < ysize; i++)
    {
      plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][EAST][i];
    }
  }

  if (neighbours[WEST] != MPI_PROC_NULL)
  {
    for (uint i = 0; i < ysize; i++)
    {
      plane->data[IDX(0, i + 1)] = buffers[RECV][WEST][i];
    }
  }

  if (periodic && N[_x_] == 2)
  {
    if (neighbours[EAST] == MPI_PROC_NULL)
    {
      for (uint i = 0; i < ysize; i++)
      {
        plane->data[IDX(0, i + 1)] = buffers[RECV][EAST][i];
      }
    }

    if (neighbours[WEST] == MPI_PROC_NULL)
    {
      for (uint i = 0; i < ysize; i++)
      {
        plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][WEST][i];
      }
    }
  }

#undef IDX
}

inline double stencil_computation(const double *restrict old, const uint fxsize, const uint i, const uint j)
{
  const uint idx = j * fxsize + i;
  return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
}

inline int update_inner_points(plane_t *oldplane, plane_t *newplane)
{

  const uint xsize = oldplane->size[_x_];
  const uint ysize = oldplane->size[_y_];
  const uint fxsize = xsize + 2; // including halos

#define IDX(i, j) ((j) * fxsize + (i))

  double *restrict old = oldplane->data;
  double *restrict new = newplane->data;

  const uint simd_width = 4;
  const uint simd_end = xsize - 1 - ((xsize - 2) % simd_width);

  for (uint j = 2; j < ysize; j++)
  {
    uint i = 2;
    for ( ; i < xsize; i++)
    {
      __m256d center = _mm256_loadu_pd(&old[IDX(i, j)]);
      __m256d left = _mm256_loadu_pd(&old[IDX(i - 1, j)]);
      __m256d right = _mm256_loadu_pd(&old[IDX(i + 1, j)]);
      __m256d up = _mm256_loadu_pd(&old[IDX(i, j - 1)]);
      __m256d down = _mm256_loadu_pd(&old[IDX(i, j + 1)]);

      __m256d result = _mm256_add_pd(_mm256_mul_pd(center, _mm256_set1_pd(0.5)),
                                  _mm256_mul_pd(_mm256_add_pd(_mm256_add_pd(left, right),
                                  _mm256_add_pd(up, down)), _mm256_set1_pd(0.125)));
                                  _mm256_storeu_pd(&new[IDX(i, j)], result);
    }

    for (; i <= xsize - 1; i++)
    {
      new[IDX(i, j)] = stencil_computation(old, fxsize, i, j);
    }
  }

#undef IDX
  return 0;
}

inline int update_boundary_points(plane_t *oldplane, plane_t *newplane, const int periodic, vec2_t N)
{

  const uint xsize = oldplane->size[_x_];
  const uint ysize = oldplane->size[_y_];
  const uint fxsize = xsize + 2; // including halos
  const uint fysize = ysize + 2;

#define IDX(i, j) ((j) * fxsize + (i))

  double *restrict old = oldplane->data;
  double *restrict new = newplane->data;

// North and south boundary
#pragma omp parallel for schedule(static)
  for (uint i = 1; i <= xsize; i++)
  {
    new[IDX(i, 1)] = stencil_computation(old, fxsize, i, 1);
    new[IDX(i, ysize)] = stencil_computation(old, fxsize, i, ysize);
  }

// West and east boundary
#pragma omp parallel for schedule(static)
  for (uint j = 1; j <= ysize; j++)
  {
    new[IDX(1, j)] = stencil_computation(old, fxsize, 1, j);
    new[IDX(xsize, j)] = stencil_computation(old, fxsize, xsize, j);
  }

  if (periodic)
  {
    if (N[_x_] == 1)
    {
      for (uint r = 1; r <= ysize; r++)
      {
        new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
        new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
      }
    }

    if (N[_y_] == 1)
    {
      for (uint c = 1; c <= xsize; c++)
      {
        new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
        new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
      }
    }
  }
#undef IDX
  return 0;
}
// ----------------------------------------------------------------------------------------------------------------------------------

int initialize_sources(int,
                       int,
                       MPI_Comm *,
                       uint[2],
                       int,
                       int *,
                       vec2_t **);

int memory_allocate(const int *,
                    const vec2_t,
                    buffers_t *,
                    plane_t *);

int initialize(MPI_Comm *Comm,
               int Me,        // the rank of the calling process
               int Ntasks,    // the total number of MPI ranks
               int argc,      // the argc from command line
               char **argv,   // the argv from command line
               vec2_t *S,     // the size of the plane
               vec2_t *N,     // two-uint array defining the MPI tasks' grid
               int *periodic, // periodic-boundary tag
               int *output_energy_stat,
               int *neighbours,  // four-int array that gives back the neighbours of the calling task
               int *Niterations, // how many iterations
               int *Nsources,    // how many heat sources
               int *Nsources_local,
               vec2_t **Sources_local,
               double *energy_per_source, // how much heat per source
               plane_t *planes,
               buffers_t *buffers)
{
  int halt = 0;
  int ret;
  int verbose = 0;

  // ··································································
  // set deffault values

  (*S)[_x_] = 10000;
  (*S)[_y_] = 10000;
  *periodic = 0;
  *Nsources = 4;
  *Nsources_local = 0;
  *Sources_local = NULL;
  *Niterations = 1000;
  *energy_per_source = 1.0;

  if (planes == NULL)
  {
    // manage the situation
    fprintf(stderr, "task %d :: error - planes is NULL\n", Me);
    return 1;
  }

  // Original version
  // planes[OLD].size[0] = planes[OLD].size[0] = 0;
  // planes[NEW].size[0] = planes[NEW].size[0] = 0;
  planes[OLD].size[0] = planes[OLD].size[1] = 0;
  planes[NEW].size[0] = planes[NEW].size[1] = 0;

  for (int i = 0; i < 4; i++)
    neighbours[i] = MPI_PROC_NULL;

  for (int b = 0; b < 2; b++)
    for (int d = 0; d < 4; d++)
      buffers[b][d] = NULL;

  // ··································································
  // process the commadn line
  //
  while (1)
  {
    int opt;
    while ((opt = getopt(argc, argv, ":hx:y:e:E:n:o:p:v:")) != -1)
    {
      switch (opt)
      {
      case 'x':
        (*S)[_x_] = (uint)atoi(optarg);
        break;

      case 'y':
        (*S)[_y_] = (uint)atoi(optarg);
        break;

      case 'e':
        *Nsources = atoi(optarg);
        break;

      case 'E':
        *energy_per_source = atof(optarg);
        break;

      case 'n':
        *Niterations = atoi(optarg);
        break;

      case 'o':
        *output_energy_stat = (atoi(optarg) > 0);
        break;

      case 'p':
        *periodic = (atoi(optarg) > 0);
        break;

      case 'v':
        verbose = atoi(optarg);
        break;

      case 'h':
      {
        if (Me == 0)
          printf("\nvalid options are ( values btw [] are the default values ):\n"
                 "-x    x size of the plate [10000]\n"
                 "-y    y size of the plate [10000]\n"
                 "-e    how many energy sources on the plate [4]\n"
                 "-E    how many energy sources on the plate [1.0]\n"
                 "-n    how many iterations [1000]\n"
                 "-p    whether periodic boundaries applies  [0 = false]\n\n");
        halt = 1;
      }
      break;

      case ':':
        printf("option -%c requires an argument\n", optopt);
        break;

      case '?':
        printf(" -------- help unavailable ----------\n");
        break;
      }
    }

    if (opt == -1)
      break;
  }

  if (halt)
    return 1;

  // ··································································
  /*
   * here we should check for all the parms being meaningful
   *
   */

  // check if the grid can exist
  if (((*S)[_x_] < 1) || ((*S)[_y_] < 1))
  {
    if (Me == 0)
      fprintf(stderr, "Grid must be positive\n");
    return 1;
  }

  // check if the number of sources is meaningful
  if (*Nsources < 0 || *Nsources > (int)((*S)[_x_] * (*S)[_y_]))
  {
    if (Me == 0)
      fprintf(stderr, "Number of sources must be non-negative and smaller than the grid size\n");
    return 1;
  }

  // check if the energy per source is meaningful
  if (*energy_per_source < 0.0)
  {
    if (Me == 0)
      fprintf(stderr, "Energy per source must be non-negative\n");
    return 1;
  }

  // check if the number of iterations is meaningful
  if (*Niterations <= 0)
  {
    if (Me == 0)
      fprintf(stderr, "Number of iterations must be positive\n");
    return 1;
  }


  // ··································································

  vec2_t Grid;
  double formfactor = ((*S)[_x_] >= (*S)[_y_] ? (double)(*S)[_x_] / (*S)[_y_] : (double)(*S)[_y_] / (*S)[_x_]);
  int dimensions = 2 - (Ntasks <= ((int)formfactor + 1));

  if (dimensions == 1)
  {
    if ((*S)[_x_] >= (*S)[_y_])
      Grid[_x_] = Ntasks, Grid[_y_] = 1;
    else
      Grid[_x_] = 1, Grid[_y_] = Ntasks;
  }
  else
  {
    int Nf;
    uint *factors;
    uint first = 1;
    ret = simple_factorization(Ntasks, &Nf, &factors);

    for (int i = 0; (i < Nf) && ((Ntasks / first) / first > formfactor); i++)
      first *= factors[i];

    if ((*S)[_x_] > (*S)[_y_])
      Grid[_x_] = Ntasks / first, Grid[_y_] = first;
    else
      Grid[_x_] = first, Grid[_y_] = Ntasks / first;
  }

  (*N)[_x_] = Grid[_x_];
  (*N)[_y_] = Grid[_y_];

  // ··································································
  // my coordinates in the grid of processors
  //
  int X = Me % Grid[_x_];
  int Y = Me / Grid[_x_];

  // ··································································
  // find my neighbours
  //

  if (Grid[_x_] > 1)
  {
    if (*periodic)
    {
      neighbours[EAST] = Y * Grid[_x_] + (Me + 1) % Grid[_x_];
      neighbours[WEST] = (X % Grid[_x_] > 0 ? Me - 1 : (Y + 1) * Grid[_x_] - 1);
    }

    else
    {
      neighbours[EAST] = (X < Grid[_x_] - 1 ? Me + 1 : MPI_PROC_NULL);
      neighbours[WEST] = (X > 0 ? (Me - 1) % Ntasks : MPI_PROC_NULL);
    }
  }

  if (Grid[_y_] > 1)
  {
    if (*periodic)
    {
      neighbours[NORTH] = (Ntasks + Me - Grid[_x_]) % Ntasks;
      neighbours[SOUTH] = (Ntasks + Me + Grid[_x_]) % Ntasks;
    }

    else
    {
      neighbours[NORTH] = (Y > 0 ? Me - Grid[_x_] : MPI_PROC_NULL);
      neighbours[SOUTH] = (Y < Grid[_y_] - 1 ? Me + Grid[_x_] : MPI_PROC_NULL);
    }
  }

  // ··································································
  // the size of my patch
  //

  /*
   * every MPI task determines the size sx x sy of its own domain
   * REMIND: the computational domain will be embedded into a frame
   *         that is (sx+2) x (sy+2)
   *         the outern frame will be used for halo communication or
   */

  vec2_t mysize;
  uint s = (*S)[_x_] / Grid[_x_];
  uint r = (*S)[_x_] % Grid[_x_];
  mysize[_x_] = s + (X < r);
  s = (*S)[_y_] / Grid[_y_];
  r = (*S)[_y_] % Grid[_y_];
  mysize[_y_] = s + (Y < r);

  planes[OLD].size[0] = mysize[0];
  planes[OLD].size[1] = mysize[1];
  planes[NEW].size[0] = mysize[0];
  planes[NEW].size[1] = mysize[1];

  if (verbose > 0)
  {
    if (Me == 0)
    {
      printf("Tasks are decomposed in a grid %d x %d\n\n",
             Grid[_x_], Grid[_y_]);
      fflush(stdout);
    }

    MPI_Barrier(*Comm);

    for (int t = 0; t < Ntasks; t++)
    {
      if (t == Me)
      {
        printf("Task %4d :: "
               "\tgrid coordinates : %3d, %3d\n"
               "\tneighbours: N %4d    E %4d    S %4d    W %4d\n",
               Me, X, Y,
               neighbours[NORTH], neighbours[EAST],
               neighbours[SOUTH], neighbours[WEST]);
        fflush(stdout);
      }

      MPI_Barrier(*Comm);
    }
  }

  // ··································································
  // allocate the needed memory
  //
  ret = memory_allocate(neighbours, *N, buffers, planes);
  // neighbours, N: grid shape, communications buffers, planes (old and new)

  // ··································································
  // allocate the heat sources
  //
  ret = initialize_sources(Me, Ntasks, Comm, mysize, *Nsources, Nsources_local, Sources_local);

  return 0;
}

uint simple_factorization(uint A, int *Nfactors, uint **factors)
/*
 * rought factorization;
 * assumes that A is small, of the order of <~ 10^5 max,
 * since it represents the number of tasks
 #
 */
{
  int N = 0;
  int f = 2;
  uint _A_ = A;

  while (f < A)
  {
    while (_A_ % f == 0)
    {
      N++;
      _A_ /= f;
    }

    f++;
  }

  *Nfactors = N;
  uint *_factors_ = (uint *)malloc(N * sizeof(uint));

  N = 0;
  f = 2;
  _A_ = A;

  while (f < A)
  {
    while (_A_ % f == 0)
    {
      _factors_[N++] = f;
      _A_ /= f;
    }
    f++;
  }

  *factors = _factors_;
  return 0;
}

int initialize_sources(int Me,
                       int Ntasks,
                       MPI_Comm *Comm,
                       vec2_t mysize,
                       int Nsources,
                       int *Nsources_local,
                       vec2_t **Sources)

{

  srand48(time(NULL) ^ Me);
  int *tasks_with_sources = (int *)malloc(Nsources * sizeof(int));

  if (Me == 0)
  {
    for (int i = 0; i < Nsources; i++)
      tasks_with_sources[i] = (int)lrand48() % Ntasks;
  }

  MPI_Bcast(tasks_with_sources, Nsources, MPI_INT, 0, *Comm);

  int nlocal = 0;
  for (int i = 0; i < Nsources; i++)
    nlocal += (tasks_with_sources[i] == Me);
  *Nsources_local = nlocal;

  if (nlocal > 0)
  {
    vec2_t *restrict helper = (vec2_t *)malloc(nlocal * sizeof(vec2_t));
    for (int s = 0; s < nlocal; s++)
    {
      helper[s][_x_] = 1 + lrand48() % mysize[_x_];
      helper[s][_y_] = 1 + lrand48() % mysize[_y_];
    }

    *Sources = helper;
  }

  free(tasks_with_sources);

  return 0;
}

int memory_allocate(const int *neighbours,
                    const vec2_t N,
                    buffers_t *buffers_ptr,
                    plane_t *planes_ptr)

{
  /*
    here you allocate the memory buffers that you need to
    (i)  hold the results of your computation
    (ii) communicate with your neighbours

    The memory layout that I propose to you is as follows:

    (i) --- calculations
    you need 2 memory regions: the "OLD" one that contains the
    results for the step (i-1)th, and the "NEW" one that will contain
    the updated results from the step ith.

    Then, the "NEW" will be treated as "OLD" and viceversa.

    These two memory regions are indexed by *plate_ptr:

    planew_ptr[0] ==> the "OLD" region
    plamew_ptr[1] ==> the "NEW" region


    (ii) --- communications

    you may need two buffers (one for sending and one for receiving)
    for each one of your neighnours, that are at most 4:
    north, south, east amd west.

    To them you need to communicate at most mysizex or mysizey
    daouble data.

    These buffers are indexed by the buffer_ptr pointer so
    that

    (*buffers_ptr)[SEND][ {NORTH,...,WEST} ] = .. some memory regions
    (*buffers_ptr)[RECV][ {NORTH,...,WEST} ] = .. some memory regions

    --->> Of course you can change this layout as you prefer

   */

  if (planes_ptr == NULL)
  {
    // an invalid pointer has been passed
    // manage the situation
    fprintf(stderr, "error :: planes_ptr is NULL\n");
    return 1;
  }

  if (buffers_ptr == NULL)
  {
    // an invalid pointer has been passed
    // manage the situation
    fprintf(stderr, "error :: buffers_ptr is NULL\n");
    return 1;
  }

  // ··················································
  // allocate memory for data
  // we allocate the space needed for the plane plus a contour frame
  // that will contains data form neighbouring MPI tasks
  unsigned int frame_size = (planes_ptr[OLD].size[_x_] + 2) * (planes_ptr[OLD].size[_y_] + 2);

  planes_ptr[OLD].data = (double *)malloc(frame_size * sizeof(double));
  if (planes_ptr[OLD].data == NULL)
  {
    // manage the malloc fail
    fprintf(stderr, "error :: malloc failed for planes_ptr[OLD].data\n");
    return 1;
  }
  memset(planes_ptr[OLD].data, 0, frame_size * sizeof(double));

  planes_ptr[NEW].data = (double *)malloc(frame_size * sizeof(double));
  if (planes_ptr[NEW].data == NULL)
  {
    // manage the malloc fail
    fprintf(stderr, "error :: malloc failed for planes_ptr[NEW].data\n");
    return 1;
  }
  memset(planes_ptr[NEW].data, 0, frame_size * sizeof(double));

  // ··················································
  // buffers for north and south communication
  // are not really needed
  //
  // in fact, they are already contiguous, just the
  // first and last line of every rank's plane
  //
  // you may just make some pointers pointing to the
  // correct positions
  //

  // or, if you preer, just go on and allocate buffers
  // also for north and south communications

  // ··················································
  // allocate buffers
  //

  // ··················································

  const uint xsize = planes_ptr[OLD].size[_x_];
  const uint ysize = planes_ptr[OLD].size[_y_];

  if (neighbours[EAST] != MPI_PROC_NULL)
  {
    buffers_ptr[SEND][EAST] = (double *)malloc(ysize * sizeof(double));
    if (buffers_ptr[SEND][EAST] == NULL)
    {
      fprintf(stderr, "error :: malloc failed for SEND EAST buffer\n");
      free(buffers_ptr[SEND][EAST]);
      return 1;
    }

    buffers_ptr[RECV][EAST] = (double *)malloc(ysize * sizeof(double));
    if (buffers_ptr[RECV][EAST] == NULL)
    {
      fprintf(stderr, "error :: malloc failed for RECV EAST buffer\n");
      free(buffers_ptr[RECV][EAST]);
      return 1;
    }
  }

  // WEST
  if (neighbours[WEST] != MPI_PROC_NULL)
  {
    buffers_ptr[SEND][WEST] = (double *)malloc(ysize * sizeof(double));
    if (buffers_ptr[SEND][WEST] == NULL)
    {
      fprintf(stderr, "error :: malloc failed for SEND WEST buffer\n");
      free(buffers_ptr[SEND][WEST]);
      return 1;
    }

    buffers_ptr[RECV][WEST] = (double *)malloc(ysize * sizeof(double));
    if (buffers_ptr[RECV][WEST] == NULL)
    {
      fprintf(stderr, "error :: malloc failed for RECV WEST buffer\n");
      free(buffers_ptr[RECV][WEST]);
      return 1;
    }
  }
  return 0;
}

int memory_release(plane_t *planes, buffers_t *buffers_ptr)
{

  if (planes != NULL)
  {
    if (planes[OLD].data != NULL)
    {
      free(planes[OLD].data);
    }

    if (planes[NEW].data != NULL)
    {
      free(planes[NEW].data);
    }
  }

  return 0;
}

int output_energy_stat(int step, plane_t *plane, double budget, int Me, MPI_Comm *Comm)
{

  double system_energy = 0;
  double tot_system_energy = 0;
  get_total_energy(plane, &system_energy);

  MPI_Reduce(&system_energy, &tot_system_energy, 1, MPI_DOUBLE, MPI_SUM, 0, *Comm);

  if (Me == 0)
  {
    if (step >= 0)
      printf(" [ step %4d ] ", step);
    fflush(stdout);

    printf("total injected energy is %g, "
           "system energy is %g "
           "( in avg %g per grid point)\n",
           budget,
           tot_system_energy,
           tot_system_energy / (plane->size[_x_] * plane->size[_y_]));
  }

  return 0;
}

int dump(const double *data, const uint size[2], const char *filename)
{
  if ((filename != NULL) && (filename[0] != '\0'))
  {
    FILE *outfile = fopen(filename, "w");
    if (outfile == NULL)
      return 2;

    float *array = (float *)malloc(size[0] * sizeof(float));

    for (int j = 1; j <= size[1]; j++)
    {
      const double *restrict line = data + j * (size[0] + 2);
      for (int i = 1; i <= size[0]; i++)
      {
        // int cut = line[i] < 100;
        array[i - 1] = (float)line[i];
      }
      // printf("\n");
      fwrite(array, sizeof(float), size[0], outfile);
    }

    free(array);

    fclose(outfile);
    return 0;
  }

  return 1;
}