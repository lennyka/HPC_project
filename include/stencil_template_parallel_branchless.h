/* -*- Mode: C; c-basic-offset:4 ; indent-tabs-mode:nil ; -*- */
/*
 * See COPYRIGHT in top-level directory.
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <getopt.h>
#include <time.h>
#include <math.h>

#include <omp.h>
#include <mpi.h>

// define the constants
#define NORTH 0
#define SOUTH 1
#define EAST 2
#define WEST 3

#define SEND 0
#define RECV 1

#define OLD 0
#define NEW 1

#define _x_ 0
#define _y_ 1

typedef unsigned int uint;

typedef uint vec2_t[2];                // 2D vector of unsigned int
typedef double *restrict buffers_t[4]; // 4 pointers to double (N, S, E, W)

typedef struct
{
    double *restrict data; // flattened 2D array with 2 halos
    vec2_t size;           // size of the computational domain (without halos)
} plane_t;                 // grid

// add heat at the given sources
extern int inject_energy(const int,      // periodic or not
                         const int,      // Nsources
                         const vec2_t *, // sources coordinates
                         const double,   // energy per source
                         plane_t *,      // the plane where to add heat
                         const vec2_t);  // N

// update the plane according to the 5-point stencil
extern int update_plane(const int,       // periodic or not
                        const vec2_t,    // N
                        const plane_t *, // old plane
                        plane_t *);      // new plane

// get the total energy in the plane
extern int get_total_energy(plane_t *, // the plane
                            double *); // energy

// inizialization
int initialize(MPI_Comm *,
               int,
               int,
               int,
               char **,
               vec2_t *,
               vec2_t *,
               int *,
               int *,
               int *,
               int *,
               int *,
               int *,
               vec2_t **,
               double *,
               plane_t *,
               buffers_t *);

// memory release of the plane
int memory_release(plane_t *, buffers_t *);

// compute and print energy at every step
int output_energy_stat(int,
                       plane_t *,
                       double,
                       int,
                       MPI_Comm *);

extern int dump(const double *data, const uint size[2], const char *filename);

extern void fill_buffers(plane_t *,
                         int *,
                         vec2_t,
                         buffers_t *,
                         int);

extern void halo_communications(plane_t *,
                                int *,
                                buffers_t *,
                                MPI_Comm *,
                                MPI_Request *);

extern void copy_halo(plane_t *,
                      int *,
                      vec2_t,
                      buffers_t *,
                      int);

extern int update_inner_points(plane_t *,
                               plane_t *);

extern int update_boundary_points(plane_t *,
                                  plane_t *,
                                  int, vec2_t);

extern double stencil_computation(const double *restrict,
                                  const uint,
                                  const uint,
                                  const uint);

// inject energy at the given sources
inline int inject_energy(const int periodic,
                         const int Nsources,
                         const vec2_t *Sources,
                         const double energy,
                         plane_t *plane,
                         const vec2_t N)
{
    const uint register sizex = plane->size[_x_] + 2; // including halos
    double *restrict data = plane->data;              // flattened 2D array

    const int nx = plane->size[_x_];
    const int ny = plane->size[_y_];
    const int x_branchless = (N[_x_] == 1) && periodic;
    const int y_branchless = (N[_y_] == 1) && periodic;

#define IDX(i, j) ((j) * sizex + (i))
    for (int s = 0; s < Nsources; s++)
    {
        const int x = Sources[s][_x_];
        const int y = Sources[s][_y_];

        data[IDX(x, y)] += energy;

        if (x_branchless) {// check if we are in an edge
            if (x == 1) {// this means that we don't have a west edge
                data[IDX(sizex - 1, y)] += energy;
            }

            if (x == sizex - 2) { // this means that we don't have an east edge
                data[IDX(0, y)] += energy;
            }
        }

        if (y_branchless) { // check if we are in an edge
            if (y == 1) { // this means that we don't have a south edge
                data[IDX(x, plane->size[_y_] + 1)] += energy;
            }

            if (y == plane->size[_y_]) { // this means that we don't have a north edge
                data[IDX(x, 0)] += energy;
            }
        }
    }
#undef IDX

    return 0;
}

// update the plane according to the 5-point stencil
inline int update_plane(const int periodic,
                        const vec2_t N,
                        const plane_t *oldplane,
                        plane_t *newplane)

{
    uint register fxsize = oldplane->size[_x_] + 2; // including halos in x direction
    uint register fysize = oldplane->size[_y_] + 2; // including halos in y direction

    uint register xsize = oldplane->size[_x_]; // x size
    uint register ysize = oldplane->size[_y_]; // y size

#define IDX(i, j) ((j) * fxsize + (i)) // flatten the point froma 2D -> 1D coordinates

    double *restrict old = oldplane->data;
    double *restrict new = newplane->data;

#pragma omp parallel for schedule(static)
    for (uint j = 1; j <= ysize; j++)
    {
        for (uint i = 1; i <= xsize; i++)
        {
            // five-points stencil formula
            new[IDX(i, j)] = old[IDX(i, j)] / 2.0 + (old[IDX(i - 1, j)] + old[IDX(i + 1, j)] +
                                                     old[IDX(i, j - 1)] + old[IDX(i, j + 1)]) /
                                                        4.0 / 2.0;
        }
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

// get the total energy in the plane
inline int get_total_energy(plane_t *plane,
                            double *energy)
{

    const int register xsize = plane->size[_x_]; // x size
    const int register ysize = plane->size[_y_]; // y size
    const int register fsize = xsize + 2;        // including halos in x direction

    double *restrict data = plane->data;

#define IDX(i, j) ((j) * fsize + (i))

#if defined(LONG_ACCURACY)
    long double totenergy = 0;
#else
    double totenergy = 0;
#endif

// parallelize with openmp
#pragma omp parallel for reduction(+ : totenergy) schedule(static) collapse(2)
    for (int j = 1; j <= ysize; j++)
        for (int i = 1; i <= xsize; i++)
            totenergy += data[IDX(i, j)];

#undef IDX

    *energy = (double)totenergy;
    return 0;
}