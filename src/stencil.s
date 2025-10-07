	.file	"stencil_template_parallel.c"
	.intel_syntax noprefix
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04.2) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=tigerlake -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -mno-sse4a -mno-fma4 -mno-xop -mfma -mavx512f -mbmi -mbmi2 -maes -mpclmul -mavx512vl -mavx512bw -mavx512dq -mavx512cd -mno-avx512er -mno-avx512pf -mavx512vbmi -mavx512ifma -mno-avx5124vnniw -mno-avx5124fmaps -mavx512vpopcntdq -mavx512vbmi2 -mgfni -mvpclmulqdq -mavx512vnni -mavx512bitalg -mno-avx512bf16 -mavx512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclflushopt -mclwb -mno-clzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mno-movdir64b -mno-movdiri -mno-mwaitx -mno-pconfig -mno-pku -mno-prefetchwt1 -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mno-serialize -mno-sgx -msha -mno-shstk -mno-tbm -mno-tsxldtrk -mvaes -mno-waitpkg -mno-wbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mno-avxvnni --param=l1-cache-size=48 --param=l1-cache-line-size=64 --param=l2-cache-size=12288 -mtune=tigerlake -masm=intel -O3 -fopenmp -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.p2align 4
	.type	update_plane._omp_fn.0, @function
update_plane._omp_fn.0:
.LFB80:
	.cfi_startproc
	endbr64	
	push	r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 24	#,
	.cfi_def_cfa_offset 80
# ../include/stencil_template_parallel.h:167: #pragma omp parallel for schedule(static)
	mov	ebp, DWORD PTR 24[rdi]	# ysize, *.omp_data_i_9(D).ysize
	lea	eax, 1[rbp]	# tmp144,
	cmp	eax, 1	# tmp144,
	jbe	.L14	#,
	mov	rbx, rdi	# .omp_data_i, tmp176
	call	omp_get_num_threads@PLT	#
	mov	r12d, eax	# _16, tmp177
	call	omp_get_thread_num@PLT	#
	mov	r11d, eax	# _19, tmp178
	xor	edx, edx	# tt.18_2
	mov	eax, ebp	# ysize, ysize
	div	r12d	# _16
	mov	ebp, eax	# q.17_1, ysize
	cmp	r11d, edx	# _19, tt.18_2
	jb	.L3	#,
.L8:
	imul	r11d, ebp	# tmp147, q.17_1
	add	r11d, edx	# _24, tt.18_2
	add	ebp, r11d	# _25, _24
	cmp	r11d, ebp	# _24, _25
	jnb	.L14	#,
	mov	r9d, DWORD PTR 20[rbx]	# xsize, *.omp_data_i_9(D).xsize
	lea	eax, 1[rbp]	# _27,
	mov	DWORD PTR 12[rsp], eax	# %sfp, _27
	mov	r10, QWORD PTR 8[rbx]	# new, *.omp_data_i_9(D).new
	mov	rdx, QWORD PTR [rbx]	# old, *.omp_data_i_9(D).old
	mov	r12d, DWORD PTR 16[rbx]	# fxsize, *.omp_data_i_9(D).fxsize
	inc	r11d	# j
	test	r9d, r9d	# xsize
	je	.L14	#,
	mov	ebx, r12d	# ivtmp.200, fxsize
	imul	ebx, r11d	# ivtmp.200, j
	vmovsd	xmm2, QWORD PTR .LC0[rip]	# tmp173,
	vmovsd	xmm1, QWORD PTR .LC1[rip]	# tmp174,
	lea	r14d, [r12+r12]	# tmp148,
	.p2align 4,,10
	.p2align 3
.L7:
# ../include/stencil_template_parallel.h:183:                                                      old[IDX(i, j - 1)] + old[IDX(i, j + 1)]) /
	mov	ecx, ebx	# _48, ivtmp.200
	sub	ecx, r12d	# _48, fxsize
	mov	eax, ebx	# ivtmp.200, ivtmp.200
	lea	ebx, [r14+rcx]	# ivtmp.200,
# ../include/stencil_template_parallel.h:183:                                                      old[IDX(i, j - 1)] + old[IDX(i, j + 1)]) /
	mov	esi, ebx	# tmp160, ivtmp.200
	lea	edi, 1[rcx]	# tmp175,
	sub	esi, eax	# tmp160, ivtmp.188
# ../include/stencil_template_parallel.h:169:         for (uint i = 1; i <= xsize; i++)
	mov	r8d, 1	# tmp170,
	inc	r11d	# j
# ../include/stencil_template_parallel.h:183:                                                      old[IDX(i, j - 1)] + old[IDX(i, j + 1)]) /
	sub	edi, eax	# tmp156, ivtmp.188
# ../include/stencil_template_parallel.h:183:                                                      old[IDX(i, j - 1)] + old[IDX(i, j + 1)]) /
	inc	esi	# tmp161
# ../include/stencil_template_parallel.h:169:         for (uint i = 1; i <= xsize; i++)
	sub	r8d, eax	# tmp170, ivtmp.188
	.p2align 4,,10
	.p2align 3
.L6:
	mov	r13d, eax	#, ivtmp.188
# ../include/stencil_template_parallel.h:182:             new[IDX(i, j)] = old[IDX(i, j)] / 2.0 + (old[IDX(i - 1, j)] + old[IDX(i + 1, j)] +
	lea	r15d, 2[r13]	# tmp151,
# ../include/stencil_template_parallel.h:182:             new[IDX(i, j)] = old[IDX(i, j)] / 2.0 + (old[IDX(i - 1, j)] + old[IDX(i + 1, j)] +
	vmovsd	xmm0, QWORD PTR [rdx+r15*8]	# *_44, *_44
	mov	rbp, r13	#,
	vaddsd	xmm0, xmm0, QWORD PTR [rdx+r13*8]	# tmp153, *_44, *_39
# ../include/stencil_template_parallel.h:183:                                                      old[IDX(i, j - 1)] + old[IDX(i, j + 1)]) /
	lea	r13d, [rdi+r13]	# tmp158,
# ../include/stencil_template_parallel.h:183:                                                      old[IDX(i, j - 1)] + old[IDX(i, j + 1)]) /
	add	ebp, esi	# tmp163, tmp161
# ../include/stencil_template_parallel.h:182:             new[IDX(i, j)] = old[IDX(i, j)] / 2.0 + (old[IDX(i - 1, j)] + old[IDX(i + 1, j)] +
	vaddsd	xmm0, xmm0, QWORD PTR [rdx+r13*8]	# tmp159, tmp153, *_52
# ../include/stencil_template_parallel.h:183:                                                      old[IDX(i, j - 1)] + old[IDX(i, j + 1)]) /
	mov	ebp, ebp	# tmp163, tmp163
# ../include/stencil_template_parallel.h:182:             new[IDX(i, j)] = old[IDX(i, j)] / 2.0 + (old[IDX(i - 1, j)] + old[IDX(i + 1, j)] +
	lea	ecx, 1[rax]	#,
# ../include/stencil_template_parallel.h:183:                                                      old[IDX(i, j - 1)] + old[IDX(i, j + 1)]) /
	vaddsd	xmm0, xmm0, QWORD PTR [rdx+rbp*8]	# tmp164, tmp159, *_60
# ../include/stencil_template_parallel.h:182:             new[IDX(i, j)] = old[IDX(i, j)] / 2.0 + (old[IDX(i - 1, j)] + old[IDX(i + 1, j)] +
	mov	rax, rcx	#,
# ../include/stencil_template_parallel.h:183:                                                      old[IDX(i, j - 1)] + old[IDX(i, j + 1)]) /
	vmulsd	xmm0, xmm0, xmm2	# tmp165, tmp164, tmp173
# ../include/stencil_template_parallel.h:184:                                                         4.0 / 2.0;
	vmulsd	xmm0, xmm0, xmm1	# tmp167, tmp165, tmp174
# ../include/stencil_template_parallel.h:182:             new[IDX(i, j)] = old[IDX(i, j)] / 2.0 + (old[IDX(i - 1, j)] + old[IDX(i + 1, j)] +
	vfmadd231sd	xmm0, xmm1, QWORD PTR [rdx+rcx*8]	# _66, tmp174, *_33
# ../include/stencil_template_parallel.h:182:             new[IDX(i, j)] = old[IDX(i, j)] / 2.0 + (old[IDX(i - 1, j)] + old[IDX(i + 1, j)] +
	vmovsd	QWORD PTR [r10+rcx*8], xmm0	# *_65, _66
# ../include/stencil_template_parallel.h:169:         for (uint i = 1; i <= xsize; i++)
	lea	ecx, [r8+rcx]	# i,
	cmp	r9d, ecx	# xsize, i
	jnb	.L6	#,
	cmp	DWORD PTR 12[rsp], r11d	# %sfp, j
	ja	.L7	#,
.L14:
# ../include/stencil_template_parallel.h:167: #pragma omp parallel for schedule(static)
	add	rsp, 24	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx	#
	.cfi_def_cfa_offset 48
	pop	rbp	#
	.cfi_def_cfa_offset 40
	pop	r12	#
	.cfi_def_cfa_offset 32
	pop	r13	#
	.cfi_def_cfa_offset 24
	pop	r14	#
	.cfi_def_cfa_offset 16
	pop	r15	#
	.cfi_def_cfa_offset 8
	ret	
.L3:
	.cfi_restore_state
	inc	ebp	# q.17_1
# ../include/stencil_template_parallel.h:167: #pragma omp parallel for schedule(static)
	xor	edx, edx	# tt.18_2
	jmp	.L8	#
	.cfi_endproc
.LFE80:
	.size	update_plane._omp_fn.0, .-update_plane._omp_fn.0
	.p2align 4
	.type	get_total_energy._omp_fn.0, @function
get_total_energy._omp_fn.0:
.LFB81:
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	push	r15	#
	push	r14	#
	push	r13	#
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	mov	r13, rdi	# .omp_data_i, tmp185
	push	r12	#
	push	rbx	#
	and	rsp, -32	#,
	.cfi_offset 12, -48
	.cfi_offset 3, -56
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	mov	r12, QWORD PTR [rdi]	# data, *.omp_data_i_11(D).data
	mov	r14d, DWORD PTR 24[rdi]	# fsize, *.omp_data_i_11(D).fsize
	mov	ebx, DWORD PTR 16[rdi]	# xsize, *.omp_data_i_11(D).xsize
	call	omp_get_num_threads@PLT	#
	mov	r15d, eax	# _16, tmp186
	call	omp_get_thread_num@PLT	#
	mov	ecx, eax	# _17, tmp187
	mov	eax, DWORD PTR 20[r13]	# *.omp_data_i_11(D).ysize, *.omp_data_i_11(D).ysize
	cdq
	idiv	r15d	# _16
	cmp	ecx, edx	# _17, tt.23_5
	jl	.L18	#,
.L28:
	imul	ecx, eax	# tmp158, q.22_4
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	vxorpd	xmm0, xmm0, xmm0	# totenergy
	add	ecx, edx	# _22, tt.23_5
	add	eax, ecx	# _23, _22
	cmp	ecx, eax	# _22, _23
	jge	.L19	#,
	inc	ecx	# j
	lea	edi, 1[rax]	# _104,
	mov	eax, ebx	# bnd.209, xsize
	mov	esi, ecx	# ivtmp.228, j
	shr	eax, 2	# bnd.209,
	lea	r8d, -1[rax]	# _66,
	mov	r9d, ebx	# niters_vector_mult_vf.210, xsize
	imul	esi, r14d	# ivtmp.228, fsize
	and	r9d, -4	# niters_vector_mult_vf.210,
	inc	r8	# tmp182
	lea	r10d, -1[rbx]	# _55,
	lea	r11d, 1[r9]	# tmp.211,
	sal	r8, 5	# tmp183,
	.p2align 4,,10
	.p2align 3
.L21:
# ../include/stencil_template_parallel.h:249:         for (int i = 1; i <= xsize; i++)
	test	ebx, ebx	# xsize
	jle	.L25	#,
	cmp	r10d, 2	# _55,
	jbe	.L30	#,
	movsx	rax, esi	# _26, ivtmp.228
	lea	rax, 8[r12+rax*8]	# ivtmp.219,
	lea	rdx, [r8+rax]	# _94,
	.p2align 4,,10
	.p2align 3
.L23:
# ../include/stencil_template_parallel.h:250:             totenergy += data[IDX(i, j)];
	vmovupd	ymm1, YMMWORD PTR [rax]	# MEM <vector(4) double> [(double *)_71], MEM <vector(4) double> [(double *)_71]
	add	rax, 32	# ivtmp.219,
	vaddsd	xmm0, xmm0, xmm1	# stmp_totenergy_32.215, totenergy, stmp_totenergy_32.215
	vunpckhpd	xmm2, xmm1, xmm1	# stmp_totenergy_32.215, tmp167
	vextractf64x2	xmm1, ymm1, 0x1	# tmp169, MEM <vector(4) double> [(double *)_71]
	vaddsd	xmm0, xmm0, xmm2	# stmp_totenergy_32.215, stmp_totenergy_32.215, stmp_totenergy_32.215
# ../include/stencil_template_parallel.h:250:             totenergy += data[IDX(i, j)];
	vaddsd	xmm0, xmm0, xmm1	# stmp_totenergy_32.215, stmp_totenergy_32.215, stmp_totenergy_32.215
	vunpckhpd	xmm1, xmm1, xmm1	# stmp_totenergy_32.215, tmp169
	vaddsd	xmm0, xmm0, xmm1	# totenergy, stmp_totenergy_32.215, stmp_totenergy_32.215
	cmp	rax, rdx	# ivtmp.219, _94
	jne	.L23	#,
# ../include/stencil_template_parallel.h:249:         for (int i = 1; i <= xsize; i++)
	mov	eax, r11d	# i, tmp.211
	cmp	r9d, ebx	# niters_vector_mult_vf.210, xsize
	je	.L25	#,
.L22:
# ../include/stencil_template_parallel.h:250:             totenergy += data[IDX(i, j)];
	lea	edx, [rsi+rax]	# tmp173,
	movsx	rdx, edx	# tmp174, tmp173
# ../include/stencil_template_parallel.h:250:             totenergy += data[IDX(i, j)];
	vaddsd	xmm0, xmm0, QWORD PTR [r12+rdx*8]	# totenergy, totenergy, *_31
# ../include/stencil_template_parallel.h:249:         for (int i = 1; i <= xsize; i++)
	lea	edx, 1[rax]	# i,
# ../include/stencil_template_parallel.h:249:         for (int i = 1; i <= xsize; i++)
	cmp	ebx, edx	# xsize, i
	jl	.L25	#,
# ../include/stencil_template_parallel.h:250:             totenergy += data[IDX(i, j)];
	add	edx, esi	# tmp175, ivtmp.228
	movsx	rdx, edx	# tmp176, tmp175
# ../include/stencil_template_parallel.h:249:         for (int i = 1; i <= xsize; i++)
	add	eax, 2	# i,
# ../include/stencil_template_parallel.h:250:             totenergy += data[IDX(i, j)];
	vaddsd	xmm0, xmm0, QWORD PTR [r12+rdx*8]	# totenergy, totenergy, *_88
# ../include/stencil_template_parallel.h:249:         for (int i = 1; i <= xsize; i++)
	cmp	ebx, eax	# xsize, i
	jl	.L25	#,
# ../include/stencil_template_parallel.h:250:             totenergy += data[IDX(i, j)];
	add	eax, esi	# tmp177, ivtmp.228
	cdqe
# ../include/stencil_template_parallel.h:250:             totenergy += data[IDX(i, j)];
	vaddsd	xmm0, xmm0, QWORD PTR [r12+rax*8]	# totenergy, totenergy, *_61
.L25:
	inc	ecx	# j
	add	esi, r14d	# ivtmp.228, fsize
	cmp	ecx, edi	# j, _104
	jne	.L21	#,
	vzeroupper
.L19:
	mov	rdx, QWORD PTR 8[r13]	# _8,
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	lea	rcx, 8[r13]	# _34,
.L27:
	vmovq	xmm5, rdx	# tmp193, _8
	vaddsd	xmm4, xmm0, xmm5	# tmp192, totenergy, tmp193
	mov	rax, rdx	# _41, _8
	vmovq	rsi, xmm4	# _39, tmp192
	lock cmpxchg	QWORD PTR [rcx], rsi	#,* _34, _39
	jne	.L37	#,
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	lea	rsp, -40[rbp]	#,
	pop	rbx	#
	pop	r12	#
	pop	r13	#
	pop	r14	#
	pop	r15	#
	pop	rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
.L30:
	.cfi_restore_state
# ../include/stencil_template_parallel.h:249:         for (int i = 1; i <= xsize; i++)
	mov	eax, 1	# i,
	jmp	.L22	#
.L18:
	inc	eax	# q.22_4
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	xor	edx, edx	# tt.23_5
	jmp	.L28	#
.L37:
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	mov	rdx, rax	# _8, _41
	jmp	.L27	#
	.cfi_endproc
.LFE81:
	.size	get_total_energy._omp_fn.0, .-get_total_energy._omp_fn.0
	.p2align 4
	.type	update_boundary_points._omp_fn.1, @function
update_boundary_points._omp_fn.1:
.LFB84:
	.cfi_startproc
	endbr64	
	push	r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# stencil_template_parallel.c:371: #pragma omp parallel for schedule(static)
	mov	ebx, DWORD PTR 20[rdi]	# ysize, *.omp_data_i_7(D).ysize
	lea	eax, 1[rbx]	# tmp206,
	cmp	eax, 1	# tmp206,
	jbe	.L49	#,
	mov	rbp, rdi	# .omp_data_i, tmp268
	call	omp_get_num_threads@PLT	#
	mov	r12d, eax	# _14, tmp269
	call	omp_get_thread_num@PLT	#
	mov	ecx, eax	# _17, tmp270
	xor	edx, edx	# tt.83_2
	mov	eax, ebx	# ysize, ysize
	div	r12d	# _14
	cmp	ecx, edx	# _17, tt.83_2
	jb	.L40	#,
.L46:
	imul	ecx, eax	# tmp209, q.82_1
	add	edx, ecx	# _22, tmp209
	add	eax, edx	# _23, _22
	cmp	edx, eax	# _22, _23
	jnb	.L49	#,
	mov	r8d, DWORD PTR 24[rbp]	# fxsize, *.omp_data_i_7(D).fxsize
	mov	r11, QWORD PTR 8[rbp]	# new, *.omp_data_i_7(D).new
	mov	rcx, QWORD PTR 0[rbp]	# old, *.omp_data_i_7(D).old
	mov	ebx, DWORD PTR 16[rbp]	# xsize, *.omp_data_i_7(D).xsize
	lea	esi, 1[rdx]	# j,
	lea	edi, 1[rax]	# _25,
	cmp	r8d, 1	# fxsize,
	jne	.L51	#,
	lea	eax, 2[rdx]	# tmp246,
	vmovsd	xmm4, QWORD PTR .LC3[rip]	# tmp267,
	vmovsd	xmm3, QWORD PTR .LC1[rip]	# tmp265,
	lea	r10d, 3[rdx]	# ivtmp.238,
	lea	r8d, [rbx+rdx]	# ivtmp.241,
	lea	r9d, 2[rbx+rdx]	# ivtmp.242,
	sal	rax, 3	# ivtmp.244,
	.p2align 4,,10
	.p2align 3
.L44:
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	mov	edx, esi	# j, j
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmovsd	xmm2, QWORD PTR [rcx+rdx*8]	# _250, *_251
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	mov	edx, r10d	# ivtmp.238, ivtmp.238
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmovsd	xmm1, QWORD PTR [rcx+rdx*8]	# _245, *_246
	mov	edx, r8d	#, ivtmp.241
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm1, xmm2	# tmp249, _245, _250
# stencil_template_parallel.c:375:     new[IDX(xsize, j)] = stencil_computation(old, fxsize, xsize, j);
	lea	ebx, 1[r8]	#,
	inc	esi	# j
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, xmm2	# tmp250, tmp249, _250
# stencil_template_parallel.c:375:     new[IDX(xsize, j)] = stencil_computation(old, fxsize, xsize, j);
	mov	r8, rbx	#,
	inc	r10d	# ivtmp.238
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, xmm1	# tmp251, tmp250, _245
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmulsd	xmm0, xmm0, xmm4	# tmp252, tmp251, tmp267
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vfmadd231sd	xmm0, xmm3, QWORD PTR [rcx+rax]	# _230, tmp265, MEM[(const double *)old_9 + ivtmp.244_185 * 1]
# stencil_template_parallel.c:374:     new[IDX(1, j)] = stencil_computation(old, fxsize, 1, j);
	vmovsd	QWORD PTR [r11+rax], xmm0	# MEM[(double *)new_8 + ivtmp.244_185 * 1], _230
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmovsd	xmm2, QWORD PTR [rcx+rdx*8]	# _217, *_218
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	mov	edx, r9d	# ivtmp.242, ivtmp.242
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmovsd	xmm1, QWORD PTR [rcx+rdx*8]	# _212, *_213
	inc	r9d	# ivtmp.242
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm1, xmm2	# tmp258, _212, _217
	add	rax, 8	# ivtmp.244,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, xmm2	# tmp259, tmp258, _217
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, xmm1	# tmp260, tmp259, _212
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmulsd	xmm0, xmm0, xmm4	# tmp261, tmp260, tmp267
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vfmadd231sd	xmm0, xmm3, QWORD PTR [rcx+rbx*8]	# _197, tmp265, *_224
# stencil_template_parallel.c:375:     new[IDX(xsize, j)] = stencil_computation(old, fxsize, xsize, j);
	vmovsd	QWORD PTR [r11+rbx*8], xmm0	# *_225, _197
	cmp	edi, esi	# _25, j
	ja	.L44	#,
.L49:
# stencil_template_parallel.c:371: #pragma omp parallel for schedule(static)
	pop	rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp	#
	.cfi_def_cfa_offset 32
	pop	r12	#
	.cfi_def_cfa_offset 24
	pop	r13	#
	.cfi_def_cfa_offset 16
	pop	r14	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L40:
	.cfi_restore_state
	inc	eax	# q.82_1
# stencil_template_parallel.c:371: #pragma omp parallel for schedule(static)
	xor	edx, edx	# tt.83_2
	jmp	.L46	#
	.p2align 4,,10
	.p2align 3
.L51:
	mov	eax, r8d	# ivtmp.250, fxsize
	imul	eax, esi	# ivtmp.250, j
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	mov	ebp, 1	# tmp218,
	vmovsd	xmm4, QWORD PTR .LC3[rip]	# tmp267,
	lea	r9d, [rbx+rax]	#,
	vmovsd	xmm3, QWORD PTR .LC1[rip]	# tmp265,
	mov	rdx, r9	#,
	lea	r12d, 1[r8]	# tmp264,
	sub	ebp, r8d	# tmp217, fxsize
	sub	ebx, r8d	# tmp236, fxsize
	.p2align 4,,10
	.p2align 3
.L43:
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r14d, 2[rax]	# tmp213,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmovsd	xmm0, QWORD PTR [rcx+r14*8]	# *_87, *_87
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	mov	r13d, eax	# ivtmp.250, ivtmp.250
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r13*8]	# tmp215, *_87, *_82
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r13d, 0[rbp+rax]	# tmp220,
# stencil_template_parallel.c:374:     new[IDX(1, j)] = stencil_computation(old, fxsize, 1, j);
	lea	r10d, 1[rax]	# tmp211,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r13*8]	# tmp221, tmp215, *_93
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r13d, [r12+rax]	# tmp224,
	inc	esi	# j
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r13*8]	# tmp225, tmp221, *_99
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r13d, -1[rdx]	# tmp231,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmulsd	xmm0, xmm0, xmm4	# tmp226, tmp225, tmp267
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vfmadd231sd	xmm0, xmm3, QWORD PTR [rcx+r10*8]	# _103, tmp265, *_76
# stencil_template_parallel.c:374:     new[IDX(1, j)] = stencil_computation(old, fxsize, 1, j);
	vmovsd	QWORD PTR [r11+r10*8], xmm0	# *_30, _103
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmovsd	xmm0, QWORD PTR [rcx+r13*8]	# *_50, *_50
# stencil_template_parallel.c:375:     new[IDX(xsize, j)] = stencil_computation(old, fxsize, xsize, j);
	lea	r10, 0[0+r9*8]	# _35,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r9d, 1[rdx]	# tmp233,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r9*8]	# tmp234, *_50, *_55
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r9d, [rbx+rax]	# tmp238,
	add	eax, r8d	# ivtmp.250, fxsize
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r9*8]	# _63, tmp234, *_61
	lea	r9d, [rdx+r8]	#,
	mov	rdx, r9	#,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r9*8]	# tmp240, _63, *_67
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmulsd	xmm0, xmm0, xmm4	# tmp241, tmp240, tmp267
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vfmadd231sd	xmm0, xmm3, QWORD PTR [rcx+r10]	# _71, tmp265, *_44
# stencil_template_parallel.c:375:     new[IDX(xsize, j)] = stencil_computation(old, fxsize, xsize, j);
	vmovsd	QWORD PTR [r11+r10], xmm0	# *_36, _71
	cmp	edi, esi	# _25, j
	ja	.L43	#,
	jmp	.L49	#
	.cfi_endproc
.LFE84:
	.size	update_boundary_points._omp_fn.1, .-update_boundary_points._omp_fn.1
	.p2align 4
	.type	update_inner_points._omp_fn.0, @function
update_inner_points._omp_fn.0:
.LFB82:
	.cfi_startproc
	endbr64	
	push	r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# stencil_template_parallel.c:336: #pragma omp parallel for collapse(2) schedule(static)
	mov	eax, DWORD PTR 20[rdi]	# ysize, *.omp_data_i_9(D).ysize
	mov	ebx, DWORD PTR 16[rdi]	# xsize, *.omp_data_i_9(D).xsize
	cmp	eax, 2	# ysize,
	jbe	.L59	#,
	lea	ebp, -2[rax]	# .count.71_16,
	cmp	ebx, 2	# xsize,
	jbe	.L59	#,
	mov	r14, rdi	# .omp_data_i, tmp168
	call	omp_get_num_threads@PLT	#
	mov	r12d, eax	# _20, tmp169
	call	omp_get_thread_num@PLT	#
	lea	r13d, -2[rbx]	# .count.72_18,
	mov	esi, eax	# _23, tmp170
	mov	eax, ebp	# .count.71_16, .count.71_16
	imul	eax, r13d	# .count.71_16, .count.72_18
	xor	edx, edx	# tt.74_2
	div	r12d	# _20
	mov	r9d, eax	# q.73_1, tmp142
	cmp	esi, edx	# _23, tt.74_2
	jb	.L55	#,
.L58:
	imul	esi, r9d	# tmp145, q.73_1
	add	esi, edx	# _29, tt.74_2
	lea	eax, [r9+rsi]	# tmp146,
	cmp	esi, eax	# _29, tmp146
	jnb	.L59	#,
	mov	eax, esi	# _29, _29
	xor	edx, edx	# tmp148
	div	r13d	# .count.72_18
	mov	r8, QWORD PTR 8[r14]	# new, *.omp_data_i_9(D).new
	mov	rcx, QWORD PTR [r14]	# old, *.omp_data_i_9(D).old
	mov	edi, DWORD PTR 24[r14]	# fxsize, *.omp_data_i_9(D).fxsize
	vmovsd	xmm2, QWORD PTR .LC3[rip]	# tmp167,
	vmovsd	xmm1, QWORD PTR .LC1[rip]	# tmp166,
	xor	r10d, r10d	# ivtmp.266
	mov	esi, eax	# tmp147, _29
	add	edx, 2	# i,
	add	esi, 2	# j,
	lea	eax, -1[r9]	# _230,
	jmp	.L56	#
	.p2align 4,,10
	.p2align 3
.L57:
	inc	r10d	# ivtmp.266
.L56:
# stencil_template_parallel.c:341:       new[IDX(i, j)] = stencil_computation(old, fxsize, i, j);
	mov	r11d, esi	# tmp149, j
	imul	r11d, edi	# tmp149, fxsize
	lea	r9d, [r11+rdx]	#,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r12d, -1[r9]	# tmp152,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmovsd	xmm0, QWORD PTR [rcx+r12*8]	# *_55, *_55
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	ebp, 1[r9]	# tmp154,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+rbp*8]	# tmp155, *_55, *_60
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	mov	ebp, r9d	# tmp158, _36
	sub	ebp, edi	# tmp158, fxsize
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+rbp*8]	# tmp159, tmp155, *_66
# stencil_template_parallel.c:341:       new[IDX(i, j)] = stencil_computation(old, fxsize, i, j);
	mov	r11, r9	#,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	add	r11d, edi	# tmp161, fxsize
	mov	r11d, r11d	# tmp161, tmp161
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r11*8]	# tmp162, tmp159, *_72
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmulsd	xmm0, xmm0, xmm2	# tmp163, tmp162, tmp167
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vfmadd231sd	xmm0, xmm1, QWORD PTR [rcx+r9*8]	# _76, tmp166, *_49
# stencil_template_parallel.c:341:       new[IDX(i, j)] = stencil_computation(old, fxsize, i, j);
	vmovsd	QWORD PTR [r8+r9*8], xmm0	# *_39, _76
	cmp	r10d, eax	# ivtmp.266, _230
	je	.L59	#,
	inc	edx	# i
	cmp	ebx, edx	# xsize, i
	ja	.L57	#,
	inc	esi	# j
# stencil_template_parallel.c:341:       new[IDX(i, j)] = stencil_computation(old, fxsize, i, j);
	mov	edx, 2	# i,
	jmp	.L57	#
	.p2align 4,,10
	.p2align 3
.L59:
# stencil_template_parallel.c:336: #pragma omp parallel for collapse(2) schedule(static)
	pop	rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp	#
	.cfi_def_cfa_offset 32
	pop	r12	#
	.cfi_def_cfa_offset 24
	pop	r13	#
	.cfi_def_cfa_offset 16
	pop	r14	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L55:
	.cfi_restore_state
	inc	r9d	# q.73_1
# stencil_template_parallel.c:336: #pragma omp parallel for collapse(2) schedule(static)
	xor	edx, edx	# tt.74_2
	jmp	.L58	#
	.cfi_endproc
.LFE82:
	.size	update_inner_points._omp_fn.0, .-update_inner_points._omp_fn.0
	.p2align 4
	.type	update_boundary_points._omp_fn.0, @function
update_boundary_points._omp_fn.0:
.LFB83:
	.cfi_startproc
	endbr64	
	push	r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12	#
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	push	rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 8	#,
	.cfi_def_cfa_offset 48
# stencil_template_parallel.c:363: #pragma omp parallel for schedule(static)
	mov	ebx, DWORD PTR 16[rdi]	# xsize, *.omp_data_i_7(D).xsize
	lea	eax, 1[rbx]	# tmp168,
	cmp	eax, 1	# tmp168,
	jbe	.L68	#,
	mov	rbp, rdi	# .omp_data_i, tmp209
	call	omp_get_num_threads@PLT	#
	mov	r12d, eax	# _14, tmp210
	call	omp_get_thread_num@PLT	#
	mov	ecx, eax	# _17, tmp211
	xor	edx, edx	# tt.85_2
	mov	eax, ebx	# xsize, xsize
	div	r12d	# _14
	cmp	ecx, edx	# _17, tt.85_2
	jb	.L63	#,
.L66:
	imul	ecx, eax	# tmp171, q.84_1
	add	edx, ecx	# _22, tmp171
	add	eax, edx	# _23, _22
	cmp	edx, eax	# _22, _23
	jnb	.L68	#,
	mov	edi, DWORD PTR 24[rbp]	# fxsize, *.omp_data_i_7(D).fxsize
# stencil_template_parallel.c:367:     new[IDX(i, ysize)] = stencil_computation(old, fxsize, i, ysize);
	mov	r8d, DWORD PTR 20[rbp]	# _32, *.omp_data_i_7(D).ysize
# stencil_template_parallel.c:363: #pragma omp parallel for schedule(static)
	mov	r10, QWORD PTR 8[rbp]	# new, *.omp_data_i_7(D).new
# stencil_template_parallel.c:367:     new[IDX(i, ysize)] = stencil_computation(old, fxsize, i, ysize);
	imul	r8d, edi	# _32, fxsize
# stencil_template_parallel.c:363: #pragma omp parallel for schedule(static)
	mov	rcx, QWORD PTR 0[rbp]	# old, *.omp_data_i_7(D).old
	vmovsd	xmm2, QWORD PTR .LC3[rip]	# tmp208,
	lea	r9d, 1[r8]	# _241,
	vmovsd	xmm1, QWORD PTR .LC1[rip]	# tmp206,
	sub	r8d, edi	# _255, fxsize
	lea	esi, 1[rdx]	# i,
	inc	eax	# _25
	add	edx, edi	# ivtmp.278, fxsize
	lea	ebx, 1[rdi]	# tmp207,
# stencil_template_parallel.c:367:     new[IDX(i, ysize)] = stencil_computation(old, fxsize, i, ysize);
	lea	r11d, 1[r8]	# tmp187,
	.p2align 4,,10
	.p2align 3
.L65:
	mov	r12d, edx	#, ivtmp.278
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r13d, 2[r12]	# tmp174,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmovsd	xmm0, QWORD PTR [rcx+r13*8]	# *_87, *_87
	mov	rbp, r12	#,
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r12*8]	# tmp176, *_87, *_82
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	mov	r12d, esi	# i, i
# stencil_template_parallel.c:366:     new[IDX(i, 1)] = stencil_computation(old, fxsize, i, 1);
	lea	edi, 1[rdx]	#,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r12*8]	# tmp179, tmp176, *_93
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r12d, [rbx+rbp]	# tmp182,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r13d, 0[rbp+r8]	# tmp191,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r12*8]	# tmp183, tmp179, *_99
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r12d, [rsi+r9]	# tmp193,
# stencil_template_parallel.c:366:     new[IDX(i, 1)] = stencil_computation(old, fxsize, i, 1);
	mov	rdx, rdi	#,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmulsd	xmm0, xmm0, xmm2	# tmp184, tmp183, tmp208
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vfmadd231sd	xmm0, xmm1, QWORD PTR [rcx+rdi*8]	# _103, tmp206, *_76
# stencil_template_parallel.c:366:     new[IDX(i, 1)] = stencil_computation(old, fxsize, i, 1);
	vmovsd	QWORD PTR [r10+rdi*8], xmm0	# *_29, _103
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmovsd	xmm0, QWORD PTR [rcx+r13*8]	# *_50, *_50
# stencil_template_parallel.c:367:     new[IDX(i, ysize)] = stencil_computation(old, fxsize, i, ysize);
	lea	edi, [r11+rbp]	# tmp189,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r12*8]	# tmp194, *_50, *_55
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	lea	r12d, [rsi+r8]	# tmp197,
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	add	ebp, r9d	# tmp200, _241
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+r12*8]	# tmp198, tmp194, *_61
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	mov	ebp, ebp	# tmp200, tmp200
	inc	esi	# i
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vaddsd	xmm0, xmm0, QWORD PTR [rcx+rbp*8]	# tmp201, tmp198, *_67
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vmulsd	xmm0, xmm0, xmm2	# tmp202, tmp201, tmp208
# stencil_template_parallel.c:321:   return old[idx] * 0.5 + (old[idx - 1] + old[idx + 1] + old[idx - fxsize] + old[idx + fxsize]) * 0.125;
	vfmadd231sd	xmm0, xmm1, QWORD PTR [rcx+rdi*8]	# _71, tmp206, *_44
# stencil_template_parallel.c:367:     new[IDX(i, ysize)] = stencil_computation(old, fxsize, i, ysize);
	vmovsd	QWORD PTR [r10+rdi*8], xmm0	# *_36, _71
	cmp	eax, esi	# _25, i
	ja	.L65	#,
.L68:
# stencil_template_parallel.c:363: #pragma omp parallel for schedule(static)
	add	rsp, 8	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbx	#
	.cfi_def_cfa_offset 32
	pop	rbp	#
	.cfi_def_cfa_offset 24
	pop	r12	#
	.cfi_def_cfa_offset 16
	pop	r13	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L63:
	.cfi_restore_state
	inc	eax	# q.84_1
# stencil_template_parallel.c:363: #pragma omp parallel for schedule(static)
	xor	edx, edx	# tt.85_2
	jmp	.L66	#
	.cfi_endproc
.LFE83:
	.size	update_boundary_points._omp_fn.0, .-update_boundary_points._omp_fn.0
	.p2align 4
	.globl	inject_energy
	.type	inject_energy, @function
inject_energy:
.LFB63:
	.cfi_startproc
	endbr64	
	push	r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	push	rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# ../include/stencil_template_parallel.h:90:     const uint register sizex = plane->size[_x_] + 2;
	mov	r12d, DWORD PTR 8[rcx]	# _1, plane_51(D)->size[0]
# ../include/stencil_template_parallel.h:91:     double *restrict data = plane->data;
	mov	r10, QWORD PTR [rcx]	# data, plane_51(D)->data
# ../include/stencil_template_parallel.h:94:     for (int s = 0; s < Nsources; s++)
	test	esi, esi	# Nsources
	jle	.L83	#,
	mov	eax, esi	# Nsources, tmp169
	dec	eax	# tmp139
	mov	r9d, edi	# periodic, tmp168
	mov	rbp, rcx	# plane, tmp172
	lea	r11d, 2[r12]	# sizex,
	lea	rbx, 8[rdx+rax*8]	# _80,
	jmp	.L80	#
	.p2align 4,,10
	.p2align 3
.L75:
# ../include/stencil_template_parallel.h:119:             if ((N[_y_] == 1))
	cmp	DWORD PTR 4[r8], 1	# MEM[(const uint *)N_59(D) + 4B],
	je	.L85	#,
.L73:
# ../include/stencil_template_parallel.h:94:     for (int s = 0; s < Nsources; s++)
	add	rdx, 8	# ivtmp.297,
	cmp	rdx, rbx	# ivtmp.297, _80
	je	.L83	#,
.L80:
# ../include/stencil_template_parallel.h:97:         int y = Sources[s][_y_];
	mov	esi, DWORD PTR 4[rdx]	# _6, MEM[(unsigned int *)_78 + 4B]
# ../include/stencil_template_parallel.h:96:         int x = Sources[s][_x_];
	mov	ecx, DWORD PTR [rdx]	#, MEM[(unsigned int *)_78]
# ../include/stencil_template_parallel.h:99:         data[IDX(x, y)] += energy;
	mov	edi, esi	# _7, _6
	imul	edi, r11d	#, sizex
	lea	eax, [rcx+rdi]	# tmp143,
	lea	rax, [r10+rax*8]	# _11,
	vaddsd	xmm1, xmm0, QWORD PTR [rax]	# tmp145, energy, *_11
	vmovsd	QWORD PTR [rax], xmm1	# *_11, tmp145
# ../include/stencil_template_parallel.h:101:         if (periodic)
	test	r9d, r9d	# periodic
	je	.L73	#,
# ../include/stencil_template_parallel.h:103:             if ((N[_x_] == 1))
	cmp	DWORD PTR [r8], 1	# *N_59(D),
	jne	.L75	#,
# ../include/stencil_template_parallel.h:108:                 if (x == 1)
	cmp	ecx, 1	# _5,
	jne	.L76	#,
# ../include/stencil_template_parallel.h:110:                     data[IDX(sizex - 1, y)] += energy;
	lea	eax, -1[rdi+r11]	# tmp149,
	lea	rax, [r10+rax*8]	# _20,
	vaddsd	xmm1, xmm0, QWORD PTR [rax]	# tmp151, energy, *_20
	vmovsd	QWORD PTR [rax], xmm1	# *_20, tmp151
.L76:
# ../include/stencil_template_parallel.h:113:                 if (x == sizex - 2)
	cmp	r12d, ecx	# _1, _5
	jne	.L75	#,
# ../include/stencil_template_parallel.h:115:                     data[IDX(0, y)] += energy;
	lea	rax, [r10+rdi*8]	# _25,
	vaddsd	xmm1, xmm0, QWORD PTR [rax]	# tmp155, energy, *_25
# ../include/stencil_template_parallel.h:119:             if ((N[_y_] == 1))
	cmp	DWORD PTR 4[r8], 1	# MEM[(const uint *)N_59(D) + 4B],
# ../include/stencil_template_parallel.h:115:                     data[IDX(0, y)] += energy;
	vmovsd	QWORD PTR [rax], xmm1	# *_25, tmp155
# ../include/stencil_template_parallel.h:119:             if ((N[_y_] == 1))
	jne	.L73	#,
	.p2align 4,,10
	.p2align 3
.L85:
# ../include/stencil_template_parallel.h:126:                     data[IDX(x, plane->size[_y_] + 1)] += energy;
	mov	eax, DWORD PTR 12[rbp]	# pretmp_110, plane_51(D)->size[1]
# ../include/stencil_template_parallel.h:124:                 if (y == 1)
	cmp	esi, 1	# _6,
	jne	.L79	#,
# ../include/stencil_template_parallel.h:126:                     data[IDX(x, plane->size[_y_] + 1)] += energy;
	lea	edi, 1[rax]	# tmp157,
	imul	edi, r11d	# tmp158, sizex
	add	edi, ecx	# tmp160, _5
	mov	edi, edi	# tmp160, tmp160
	lea	rdi, [r10+rdi*8]	# _35,
	vaddsd	xmm1, xmm0, QWORD PTR [rdi]	# tmp162, energy, *_35
	vmovsd	QWORD PTR [rdi], xmm1	# *_35, tmp162
.L79:
# ../include/stencil_template_parallel.h:129:                 if (y == plane->size[_y_])
	cmp	esi, eax	# _6, pretmp_110
	jne	.L73	#,
# ../include/stencil_template_parallel.h:131:                     data[IDX(x, 0)] += energy;
	lea	rax, [r10+rcx*8]	# _41,
	vaddsd	xmm1, xmm0, QWORD PTR [rax]	# tmp166, energy, *_41
# ../include/stencil_template_parallel.h:94:     for (int s = 0; s < Nsources; s++)
	add	rdx, 8	# ivtmp.297,
# ../include/stencil_template_parallel.h:131:                     data[IDX(x, 0)] += energy;
	vmovsd	QWORD PTR [rax], xmm1	# *_41, tmp166
# ../include/stencil_template_parallel.h:94:     for (int s = 0; s < Nsources; s++)
	cmp	rdx, rbx	# ivtmp.297, _80
	jne	.L80	#,
.L83:
# ../include/stencil_template_parallel.h:139: }
	pop	rbx	#
	.cfi_def_cfa_offset 24
	pop	rbp	#
	.cfi_def_cfa_offset 16
	xor	eax, eax	#
	pop	r12	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE63:
	.size	inject_energy, .-inject_energy
	.p2align 4
	.globl	update_plane
	.type	update_plane, @function
update_plane:
.LFB64:
	.cfi_startproc
	endbr64	
	push	r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13d, edi	# periodic, tmp160
	lea	rdi, update_plane._omp_fn.0[rip]	# tmp141,
	push	r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rsi	# N, tmp161
	push	rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 56	#,
	.cfi_def_cfa_offset 112
# ../include/stencil_template_parallel.h:147:     uint register fxsize = oldplane->size[_x_] + 2;
	mov	ebp, DWORD PTR 8[rdx]	# _1, oldplane_50(D)->size[0]
# ../include/stencil_template_parallel.h:165:     double *restrict new = newplane->data;
	mov	rbx, QWORD PTR [rcx]	# new, newplane_53(D)->data
# ../include/stencil_template_parallel.h:167: #pragma omp parallel for schedule(static)
	vmovq	xmm0, QWORD PTR [rdx]	# oldplane_50(D)->data, oldplane_50(D)->data
# ../include/stencil_template_parallel.h:147:     uint register fxsize = oldplane->size[_x_] + 2;
	lea	r15d, 2[rbp]	# fxsize,
# ../include/stencil_template_parallel.h:148:     uint register fysize = oldplane->size[_y_] + 2;
	mov	r14d, DWORD PTR 12[rdx]	# _2, oldplane_50(D)->size[1]
# ../include/stencil_template_parallel.h:167: #pragma omp parallel for schedule(static)
	vpinsrq	xmm0, xmm0, rbx, 1	# tmp137, oldplane_50(D)->data, new
	vmovd	xmm1, r15d	# fxsize, fxsize
# ../include/stencil_template_parallel.h:146: {
	mov	rax, QWORD PTR fs:40	# tmp164, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR 40[rsp], rax	# D.14018, tmp164
	xor	eax, eax	# tmp164
	xor	ecx, ecx	#
# ../include/stencil_template_parallel.h:167: #pragma omp parallel for schedule(static)
	vmovdqa	XMMWORD PTR [rsp], xmm0	# MEM <vector(2) long unsigned int> [(double * *)&.omp_data_o.16], tmp137
	xor	edx, edx	#
	vpinsrd	xmm0, xmm1, ebp, 1	# tmp139, fxsize, _1
	mov	rsi, rsp	# tmp140,
	mov	DWORD PTR 24[rsp], r14d	# .omp_data_o.16.ysize, _2
	vmovq	QWORD PTR 16[rsp], xmm0	# MEM <vector(2) unsigned int> [(unsigned int *)&.omp_data_o.16 + 16B], tmp139
	call	GOMP_parallel@PLT	#
# ../include/stencil_template_parallel.h:187:     if (periodic)
	test	r13d, r13d	# periodic
	je	.L87	#,
# ../include/stencil_template_parallel.h:189:         if (N[_x_] == 1)
	mov	edx, DWORD PTR [r12]	# r, *N_63(D)
# ../include/stencil_template_parallel.h:189:         if (N[_x_] == 1)
	cmp	edx, 1	# r,
	je	.L104	#,
.L88:
# ../include/stencil_template_parallel.h:202:         if (N[_y_] == 1)
	mov	eax, DWORD PTR 4[r12]	# c, MEM[(const uint *)N_63(D) + 4B]
# ../include/stencil_template_parallel.h:202:         if (N[_y_] == 1)
	cmp	eax, 1	# c,
	je	.L105	#,
.L87:
# ../include/stencil_template_parallel.h:218: }
	mov	rax, QWORD PTR 40[rsp]	# tmp165, D.14018
	sub	rax, QWORD PTR fs:40	# tmp165, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L106	#,
	add	rsp, 56	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx	#
	.cfi_def_cfa_offset 48
	pop	rbp	#
	.cfi_def_cfa_offset 40
	pop	r12	#
	.cfi_def_cfa_offset 32
	pop	r13	#
	.cfi_def_cfa_offset 24
	pop	r14	#
	.cfi_def_cfa_offset 16
	xor	eax, eax	#
	pop	r15	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L105:
	.cfi_restore_state
# ../include/stencil_template_parallel.h:207:             for (uint c = 1; c <= xsize; c++)
	test	ebp, ebp	# _1
	je	.L87	#,
# ../include/stencil_template_parallel.h:210:                 new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	imul	r14d, r15d	# _23, fxsize
# ../include/stencil_template_parallel.h:211:                 new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	lea	ecx, [r14+r15]	# _37,
	.p2align 4,,10
	.p2align 3
.L90:
# ../include/stencil_template_parallel.h:210:                 new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	lea	edx, [r14+rax]	# tmp151,
# ../include/stencil_template_parallel.h:210:                 new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	vmovsd	xmm0, QWORD PTR [rbx+rdx*8]	# _31, *_27
# ../include/stencil_template_parallel.h:210:                 new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	mov	edx, eax	# c, c
# ../include/stencil_template_parallel.h:210:                 new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	vmovsd	QWORD PTR [rbx+rdx*8], xmm0	# *_30, _31
# ../include/stencil_template_parallel.h:211:                 new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	lea	edx, [r15+rax]	# tmp154,
# ../include/stencil_template_parallel.h:211:                 new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	vmovsd	xmm0, QWORD PTR [rbx+rdx*8]	# _42, *_35
# ../include/stencil_template_parallel.h:211:                 new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	lea	edx, [rcx+rax]	# tmp156,
# ../include/stencil_template_parallel.h:207:             for (uint c = 1; c <= xsize; c++)
	inc	eax	# c
# ../include/stencil_template_parallel.h:211:                 new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	vmovsd	QWORD PTR [rbx+rdx*8], xmm0	# *_41, _42
# ../include/stencil_template_parallel.h:207:             for (uint c = 1; c <= xsize; c++)
	cmp	ebp, eax	# _1, c
	jnb	.L90	#,
	jmp	.L87	#
	.p2align 4,,10
	.p2align 3
.L104:
# ../include/stencil_template_parallel.h:194:             for (uint r = 1; r <= ysize; r++)
	test	r14d, r14d	# _2
	je	.L88	#,
# ../include/stencil_template_parallel.h:147:     uint register fxsize = oldplane->size[_x_] + 2;
	mov	eax, r15d	# ivtmp.325, fxsize
	lea	esi, 1[rbp]	# tmp159,
	.p2align 4,,10
	.p2align 3
.L89:
# ../include/stencil_template_parallel.h:197:                 new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	lea	ecx, 0[rbp+rax]	# tmp143,
# ../include/stencil_template_parallel.h:197:                 new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	vmovsd	xmm0, QWORD PTR [rbx+rcx*8]	# _12, *_8
# ../include/stencil_template_parallel.h:197:                 new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	mov	ecx, eax	# ivtmp.325, ivtmp.325
# ../include/stencil_template_parallel.h:197:                 new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	vmovsd	QWORD PTR [rbx+rcx*8], xmm0	# *_11, _12
# ../include/stencil_template_parallel.h:198:                 new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	lea	ecx, 1[rax]	# tmp146,
# ../include/stencil_template_parallel.h:198:                 new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	vmovsd	xmm0, QWORD PTR [rbx+rcx*8]	# _21, *_16
# ../include/stencil_template_parallel.h:194:             for (uint r = 1; r <= ysize; r++)
	inc	edx	# r
# ../include/stencil_template_parallel.h:198:                 new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	lea	ecx, [rsi+rax]	# tmp149,
# ../include/stencil_template_parallel.h:198:                 new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	vmovsd	QWORD PTR [rbx+rcx*8], xmm0	# *_20, _21
# ../include/stencil_template_parallel.h:194:             for (uint r = 1; r <= ysize; r++)
	add	eax, r15d	# ivtmp.325, fxsize
	cmp	r14d, edx	# _2, r
	jnb	.L89	#,
# ../include/stencil_template_parallel.h:202:         if (N[_y_] == 1)
	mov	eax, DWORD PTR 4[r12]	# c, MEM[(const uint *)N_63(D) + 4B]
# ../include/stencil_template_parallel.h:202:         if (N[_y_] == 1)
	cmp	eax, 1	# c,
	jne	.L87	#,
	jmp	.L105	#
.L106:
# ../include/stencil_template_parallel.h:218: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE64:
	.size	update_plane, .-update_plane
	.p2align 4
	.globl	get_total_energy
	.type	get_total_energy, @function
get_total_energy:
.LFB65:
	.cfi_startproc
	endbr64	
	push	rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	xor	ecx, ecx	#
	mov	rbx, rsi	# energy, tmp100
	sub	rsp, 48	#,
	.cfi_def_cfa_offset 64
# ../include/stencil_template_parallel.h:226: {
	mov	rax, QWORD PTR fs:40	# tmp101, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR 40[rsp], rax	# D.14040, tmp101
	xor	eax, eax	# tmp101
# ../include/stencil_template_parallel.h:228:     const int register xsize = plane->size[_x_];
	vmovq	xmm0, QWORD PTR 8[rdi]	# vect__1.334, MEM <vector(2) unsigned int> [(unsigned int *)plane_4(D) + 8B]
# ../include/stencil_template_parallel.h:232:     double *restrict data = plane->data;
	mov	rax, QWORD PTR [rdi]	# data, plane_4(D)->data
	mov	rsi, rsp	# tmp95,
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	mov	QWORD PTR [rsp], rax	# .omp_data_o.21.data, data
# ../include/stencil_template_parallel.h:230:     const int register fsize = xsize + 2;
	vmovd	eax, xmm0	# tmp93, vect__1.334
	add	eax, 2	# tmp94,
	xor	edx, edx	#
	lea	rdi, get_total_energy._omp_fn.0[rip]	# tmp96,
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	vmovq	QWORD PTR 16[rsp], xmm0	# MEM <const vector(2) int> [(int *)&.omp_data_o.21 + 16B], vect__1.334
	mov	QWORD PTR 8[rsp], 0x000000000	# .omp_data_o.21.totenergy,
# ../include/stencil_template_parallel.h:230:     const int register fsize = xsize + 2;
	mov	DWORD PTR 24[rsp], eax	# .omp_data_o.21.fsize, tmp94
	call	GOMP_parallel@PLT	#
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	vmovsd	xmm0, QWORD PTR 8[rsp]	# totenergy, .omp_data_o.21.totenergy
# ../include/stencil_template_parallel.h:254:     *energy = (double)totenergy;
	vmovsd	QWORD PTR [rbx], xmm0	# *energy_17(D), totenergy
# ../include/stencil_template_parallel.h:256: }
	mov	rax, QWORD PTR 40[rsp]	# tmp102, D.14040
	sub	rax, QWORD PTR fs:40	# tmp102, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L110	#,
	add	rsp, 48	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	xor	eax, eax	#
	pop	rbx	#
	.cfi_def_cfa_offset 8
	ret	
.L110:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE65:
	.size	get_total_energy, .-get_total_energy
	.p2align 4
	.globl	fill_buffers
	.type	fill_buffers, @function
fill_buffers:
.LFB67:
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	r11, rsi	# neighbours, tmp170
# stencil_template_parallel.c:191:   if (neighbours[NORTH] != MPI_PROC_NULL)
	cmp	DWORD PTR [r11], -2	# *neighbours_62(D),
# stencil_template_parallel.c:178: {
	push	rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# stencil_template_parallel.c:178: {
	mov	rax, rdi	# plane, tmp169
	mov	rbx, rcx	# buffers, tmp171
# stencil_template_parallel.c:181:   uint xsize = plane->size[_x_];
	mov	edx, DWORD PTR 8[rdi]	# xsize, plane_58(D)->size[0]
# stencil_template_parallel.c:182:   uint ysize = plane->size[_y_];
	mov	r10d, DWORD PTR 12[rdi]	# ysize, plane_58(D)->size[1]
# stencil_template_parallel.c:183:   uint fsize = xsize + 2;
	lea	esi, 2[rdx]	# fsize,
# stencil_template_parallel.c:191:   if (neighbours[NORTH] != MPI_PROC_NULL)
	je	.L112	#,
# stencil_template_parallel.c:193:     buffers[SEND][NORTH] = &plane->data[IDX(1, 1)]; // first row of the computational domain
	mov	rdi, QWORD PTR [rdi]	# plane_58(D)->data, plane_58(D)->data
# stencil_template_parallel.c:193:     buffers[SEND][NORTH] = &plane->data[IDX(1, 1)]; // first row of the computational domain
	lea	ecx, 3[rdx]	# tmp137,
# stencil_template_parallel.c:193:     buffers[SEND][NORTH] = &plane->data[IDX(1, 1)]; // first row of the computational domain
	lea	rcx, [rdi+rcx*8]	# tmp141,
# stencil_template_parallel.c:193:     buffers[SEND][NORTH] = &plane->data[IDX(1, 1)]; // first row of the computational domain
	mov	QWORD PTR [rbx], rcx	# (*buffers_63(D))[0], tmp141
# stencil_template_parallel.c:194:     buffers[RECV][NORTH] = &plane->data[IDX(1, 0)]; // first ghost row
	mov	rdi, QWORD PTR [rax]	# tmp175, plane_58(D)->data
	lea	rcx, 8[rdi]	# tmp145,
# stencil_template_parallel.c:194:     buffers[RECV][NORTH] = &plane->data[IDX(1, 0)]; // first ghost row
	mov	QWORD PTR 32[rbx], rcx	# MEM[(double * restrict[4] *)buffers_63(D) + 32B][0], tmp145
.L112:
# stencil_template_parallel.c:197:   if (neighbours[SOUTH] != MPI_PROC_NULL)
	cmp	DWORD PTR 4[r11], -2	# MEM[(int *)neighbours_62(D) + 4B],
	je	.L113	#,
# stencil_template_parallel.c:199:     buffers[SEND][SOUTH] = &plane->data[IDX(1, ysize)];     // last row of the computational domain
	mov	ecx, r10d	# _11, ysize
	imul	ecx, esi	# _11, fsize
# stencil_template_parallel.c:199:     buffers[SEND][SOUTH] = &plane->data[IDX(1, ysize)];     // last row of the computational domain
	mov	rdi, QWORD PTR [rax]	# plane_58(D)->data, plane_58(D)->data
# stencil_template_parallel.c:199:     buffers[SEND][SOUTH] = &plane->data[IDX(1, ysize)];     // last row of the computational domain
	lea	r8d, 1[rcx]	# tmp148,
# stencil_template_parallel.c:199:     buffers[SEND][SOUTH] = &plane->data[IDX(1, ysize)];     // last row of the computational domain
	lea	rdi, [rdi+r8*8]	# tmp152,
# stencil_template_parallel.c:199:     buffers[SEND][SOUTH] = &plane->data[IDX(1, ysize)];     // last row of the computational domain
	mov	QWORD PTR 8[rbx], rdi	# (*buffers_63(D))[1], tmp152
# stencil_template_parallel.c:200:     buffers[RECV][SOUTH] = &plane->data[IDX(1, ysize + 1)]; // last ghost row
	lea	edi, 1[rcx+rsi]	# tmp156,
# stencil_template_parallel.c:200:     buffers[RECV][SOUTH] = &plane->data[IDX(1, ysize + 1)]; // last ghost row
	mov	rcx, QWORD PTR [rax]	# plane_58(D)->data, plane_58(D)->data
	lea	rcx, [rcx+rdi*8]	# tmp160,
# stencil_template_parallel.c:200:     buffers[RECV][SOUTH] = &plane->data[IDX(1, ysize + 1)]; // last ghost row
	mov	QWORD PTR 40[rbx], rcx	# MEM[(double * restrict[4] *)buffers_63(D) + 32B][1], tmp160
.L113:
# stencil_template_parallel.c:204:   if (neighbours[EAST] != MPI_PROC_NULL)
	cmp	DWORD PTR 8[r11], -2	# MEM[(int *)neighbours_62(D) + 8B],
	je	.L114	#,
# stencil_template_parallel.c:206:     for (uint i = 0; i < ysize; i++)
	test	r10d, r10d	# ysize
	je	.L127	#,
	mov	rdi, QWORD PTR 16[rbx]	# ivtmp.353, (*buffers_63(D))[2]
# stencil_template_parallel.c:208:       buffers[SEND][EAST][i] = plane->data[IDX(xsize, i + 1)];
	mov	r8, QWORD PTR [rax]	# _24, plane_58(D)->data
	lea	r9d, -1[r10]	# tmp163,
	lea	rax, 8[rdi]	# ivtmp.353,
	lea	ecx, [rdx+rsi]	# ivtmp.352,
	lea	rbp, [rax+r9*8]	# _101,
	jmp	.L116	#
	.p2align 4,,10
	.p2align 3
.L129:
	add	rax, 8	# ivtmp.353,
.L116:
# stencil_template_parallel.c:208:       buffers[SEND][EAST][i] = plane->data[IDX(xsize, i + 1)];
	mov	r9d, ecx	# ivtmp.352, ivtmp.352
# stencil_template_parallel.c:208:       buffers[SEND][EAST][i] = plane->data[IDX(xsize, i + 1)];
	vmovsd	xmm0, QWORD PTR [r8+r9*8]	# _35, *_30
# stencil_template_parallel.c:206:     for (uint i = 0; i < ysize; i++)
	add	ecx, esi	# ivtmp.352, fsize
# stencil_template_parallel.c:208:       buffers[SEND][EAST][i] = plane->data[IDX(xsize, i + 1)];
	vmovsd	QWORD PTR [rdi], xmm0	# MEM[(double *)_107], _35
# stencil_template_parallel.c:206:     for (uint i = 0; i < ysize; i++)
	mov	rdi, rax	# ivtmp.353, ivtmp.353
	cmp	rbp, rax	# _101, ivtmp.353
	jne	.L129	#,
# stencil_template_parallel.c:212:   if (neighbours[WEST] != MPI_PROC_NULL)
	cmp	DWORD PTR 12[r11], -2	# MEM[(int *)neighbours_62(D) + 12B],
	je	.L127	#,
.L120:
# stencil_template_parallel.c:216:       buffers[SEND][WEST][i] = plane->data[IDX(1, i + 1)];
	mov	rdi, QWORD PTR 24[rbx]	# _44, (*buffers_63(D))[3]
	add	edx, 3	# ivtmp.346,
	xor	eax, eax	# ivtmp.344
	.p2align 4,,10
	.p2align 3
.L119:
# stencil_template_parallel.c:216:       buffers[SEND][WEST][i] = plane->data[IDX(1, i + 1)];
	mov	ecx, edx	# ivtmp.346, ivtmp.346
# stencil_template_parallel.c:216:       buffers[SEND][WEST][i] = plane->data[IDX(1, i + 1)];
	vmovsd	xmm0, QWORD PTR [r8+rcx*8]	# _48, *_43
# stencil_template_parallel.c:214:     for (uint i = 0; i < ysize; i++)
	add	edx, esi	# ivtmp.346, fsize
# stencil_template_parallel.c:216:       buffers[SEND][WEST][i] = plane->data[IDX(1, i + 1)];
	vmovsd	QWORD PTR [rdi+rax*8], xmm0	# MEM[(double *)_44 + ivtmp.344_56 * 8], _48
# stencil_template_parallel.c:214:     for (uint i = 0; i < ysize; i++)
	inc	rax	# ivtmp.344
	cmp	r10d, eax	# ysize, ivtmp.344
	ja	.L119	#,
.L127:
# stencil_template_parallel.c:221: }
	pop	rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	pop	rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L114:
	.cfi_restore_state
# stencil_template_parallel.c:212:   if (neighbours[WEST] != MPI_PROC_NULL)
	cmp	DWORD PTR 12[r11], -2	# MEM[(int *)neighbours_62(D) + 12B],
	je	.L127	#,
# stencil_template_parallel.c:214:     for (uint i = 0; i < ysize; i++)
	test	r10d, r10d	# ysize
	je	.L127	#,
# stencil_template_parallel.c:208:       buffers[SEND][EAST][i] = plane->data[IDX(xsize, i + 1)];
	mov	r8, QWORD PTR [rax]	# _24, plane_58(D)->data
	jmp	.L120	#
	.cfi_endproc
.LFE67:
	.size	fill_buffers, .-fill_buffers
	.p2align 4
	.globl	halo_communications
	.type	halo_communications, @function
halo_communications:
.LFB68:
	.cfi_startproc
	endbr64	
	push	r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rdx	# buffers, tmp151
	push	r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rcx	# myCOMM_WORLD, tmp152
	push	rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, r8	# reqs, tmp153
	push	rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rsi	# neighbours, tmp150
	sub	rsp, 8	#,
	.cfi_def_cfa_offset 64
# stencil_template_parallel.c:239:   if (neighbours[NORTH] != MPI_PROC_NULL)
	mov	ecx, DWORD PTR [rsi]	# _1, *neighbours_44(D)
# stencil_template_parallel.c:234:   uint xsize = plane->size[_x_];
	mov	r15d, DWORD PTR 8[rdi]	# xsize, plane_41(D)->size[0]
# stencil_template_parallel.c:235:   uint ysize = plane->size[_y_];
	mov	r14d, DWORD PTR 12[rdi]	# ysize, plane_41(D)->size[1]
# stencil_template_parallel.c:239:   if (neighbours[NORTH] != MPI_PROC_NULL)
	cmp	ecx, -2	# _1,
	je	.L131	#,
# stencil_template_parallel.c:241:     MPI_Irecv(buffers[RECV][NORTH], xsize, MPI_DOUBLE, neighbours[NORTH], 0, *myCOMM_WORLD, &reqs[0]);
	sub	rsp, 8	#,
	.cfi_def_cfa_offset 72
	mov	rdi, QWORD PTR 32[rdx]	# MEM[(double * restrict[4] *)buffers_46(D) + 32B][0], MEM[(double * restrict[4] *)buffers_46(D) + 32B][0]
	push	r8	# reqs
	.cfi_def_cfa_offset 80
	mov	r9, QWORD PTR [r12]	#, *myCOMM_WORLD_45(D)
	xor	r8d, r8d	#
	lea	rdx, ompi_mpi_double[rip]	# tmp125,
	mov	esi, r15d	#, xsize
	call	MPI_Irecv@PLT	#
# stencil_template_parallel.c:242:     MPI_Isend(buffers[SEND][NORTH], xsize, MPI_DOUBLE, neighbours[NORTH], 1, *myCOMM_WORLD, &reqs[1]);
	mov	r9, QWORD PTR [r12]	#, *myCOMM_WORLD_45(D)
	mov	ecx, DWORD PTR [rbx]	#, *neighbours_44(D)
	mov	rdi, QWORD PTR 0[r13]	#, (*buffers_46(D))[0]
	lea	rax, 8[rbp]	# tmp126,
	mov	r8d, 1	#,
	lea	rdx, ompi_mpi_double[rip]	# tmp125,
	mov	esi, r15d	#, xsize
	mov	QWORD PTR [rsp], rax	#, tmp126
	call	MPI_Isend@PLT	#
	pop	r9	#
	.cfi_def_cfa_offset 72
	pop	r10	#
	.cfi_def_cfa_offset 64
.L131:
# stencil_template_parallel.c:245:   if (neighbours[SOUTH] != MPI_PROC_NULL)
	mov	ecx, DWORD PTR 4[rbx]	# _9, MEM[(int *)neighbours_44(D) + 4B]
# stencil_template_parallel.c:245:   if (neighbours[SOUTH] != MPI_PROC_NULL)
	cmp	ecx, -2	# _9,
	je	.L132	#,
# stencil_template_parallel.c:247:     MPI_Irecv(buffers[RECV][SOUTH], xsize, MPI_DOUBLE, neighbours[SOUTH], 1, *myCOMM_WORLD, &reqs[2]);
	sub	rsp, 8	#,
	.cfi_def_cfa_offset 72
	lea	rax, 16[rbp]	# tmp129,
	push	rax	# tmp129
	.cfi_def_cfa_offset 80
	mov	rdi, QWORD PTR 40[r13]	# MEM[(double * restrict[4] *)buffers_46(D) + 32B][1], MEM[(double * restrict[4] *)buffers_46(D) + 32B][1]
	mov	r9, QWORD PTR [r12]	#, *myCOMM_WORLD_45(D)
	mov	r8d, 1	#,
	lea	rdx, ompi_mpi_double[rip]	# tmp130,
	mov	esi, r15d	#, xsize
	call	MPI_Irecv@PLT	#
# stencil_template_parallel.c:248:     MPI_Isend(buffers[SEND][SOUTH], xsize, MPI_DOUBLE, neighbours[SOUTH], 0, *myCOMM_WORLD, &reqs[3]);
	mov	rdi, QWORD PTR 8[r13]	# (*buffers_46(D))[1], (*buffers_46(D))[1]
	mov	ecx, DWORD PTR 4[rbx]	# MEM[(int *)neighbours_44(D) + 4B], MEM[(int *)neighbours_44(D) + 4B]
	mov	r9, QWORD PTR [r12]	#, *myCOMM_WORLD_45(D)
	lea	rax, 24[rbp]	# tmp133,
	xor	r8d, r8d	#
	lea	rdx, ompi_mpi_double[rip]	# tmp130,
	mov	esi, r15d	#, xsize
	mov	QWORD PTR [rsp], rax	#, tmp133
	call	MPI_Isend@PLT	#
	pop	rdi	#
	.cfi_def_cfa_offset 72
	pop	r8	#
	.cfi_def_cfa_offset 64
.L132:
# stencil_template_parallel.c:251:   if (neighbours[EAST] != MPI_PROC_NULL)
	mov	ecx, DWORD PTR 8[rbx]	# _18, MEM[(int *)neighbours_44(D) + 8B]
# stencil_template_parallel.c:251:   if (neighbours[EAST] != MPI_PROC_NULL)
	cmp	ecx, -2	# _18,
	je	.L133	#,
# stencil_template_parallel.c:253:     MPI_Irecv(buffers[RECV][EAST], ysize, MPI_DOUBLE, neighbours[EAST], 2, *myCOMM_WORLD, &reqs[4]);
	sub	rsp, 8	#,
	.cfi_def_cfa_offset 72
	lea	rax, 32[rbp]	# tmp136,
	push	rax	# tmp136
	.cfi_def_cfa_offset 80
	mov	rdi, QWORD PTR 48[r13]	# MEM[(double * restrict[4] *)buffers_46(D) + 32B][2], MEM[(double * restrict[4] *)buffers_46(D) + 32B][2]
	mov	r9, QWORD PTR [r12]	#, *myCOMM_WORLD_45(D)
	lea	r15, ompi_mpi_double[rip]	# tmp137,
	mov	r8d, 2	#,
	mov	rdx, r15	#, tmp137
	mov	esi, r14d	#, ysize
	call	MPI_Irecv@PLT	#
# stencil_template_parallel.c:254:     MPI_Isend(buffers[SEND][EAST], ysize, MPI_DOUBLE, neighbours[EAST], 3, *myCOMM_WORLD, &reqs[5]);
	mov	ecx, DWORD PTR 8[rbx]	# MEM[(int *)neighbours_44(D) + 8B], MEM[(int *)neighbours_44(D) + 8B]
	mov	rdi, QWORD PTR 16[r13]	# (*buffers_46(D))[2], (*buffers_46(D))[2]
	mov	r9, QWORD PTR [r12]	#, *myCOMM_WORLD_45(D)
	lea	rax, 40[rbp]	# tmp140,
	mov	esi, r14d	#, ysize
	mov	r8d, 3	#,
	mov	rdx, r15	#, tmp137
	mov	QWORD PTR [rsp], rax	#, tmp140
	call	MPI_Isend@PLT	#
	pop	rcx	#
	.cfi_def_cfa_offset 72
	pop	rsi	#
	.cfi_def_cfa_offset 64
.L133:
# stencil_template_parallel.c:257:   if (neighbours[WEST] != MPI_PROC_NULL)
	mov	ecx, DWORD PTR 12[rbx]	# _27, MEM[(int *)neighbours_44(D) + 12B]
# stencil_template_parallel.c:257:   if (neighbours[WEST] != MPI_PROC_NULL)
	cmp	ecx, -2	# _27,
	je	.L147	#,
# stencil_template_parallel.c:259:     MPI_Irecv(buffers[RECV][WEST], ysize, MPI_DOUBLE, neighbours[WEST], 3, *myCOMM_WORLD, &reqs[6]);
	sub	rsp, 8	#,
	.cfi_def_cfa_offset 72
	lea	rax, 48[rbp]	# tmp143,
	push	rax	# tmp143
	.cfi_def_cfa_offset 80
	mov	rdi, QWORD PTR 56[r13]	# MEM[(double * restrict[4] *)buffers_46(D) + 32B][3], MEM[(double * restrict[4] *)buffers_46(D) + 32B][3]
	mov	r9, QWORD PTR [r12]	#, *myCOMM_WORLD_45(D)
	lea	r15, ompi_mpi_double[rip]	# tmp144,
	mov	r8d, 3	#,
	mov	rdx, r15	#, tmp144
	mov	esi, r14d	#, ysize
	call	MPI_Irecv@PLT	#
# stencil_template_parallel.c:260:     MPI_Isend(buffers[SEND][WEST], ysize, MPI_DOUBLE, neighbours[WEST], 2, *myCOMM_WORLD, &reqs[7]);
	mov	ecx, DWORD PTR 12[rbx]	# MEM[(int *)neighbours_44(D) + 12B], MEM[(int *)neighbours_44(D) + 12B]
	mov	rdi, QWORD PTR 24[r13]	# (*buffers_46(D))[3], (*buffers_46(D))[3]
	mov	r9, QWORD PTR [r12]	#, *myCOMM_WORLD_45(D)
	mov	rdx, r15	#, tmp144
	add	rbp, 56	# tmp147,
	mov	r8d, 2	#,
	mov	esi, r14d	#, ysize
	mov	QWORD PTR [rsp], rbp	#, tmp147
	call	MPI_Isend@PLT	#
	pop	rax	#
	.cfi_def_cfa_offset 72
	pop	rdx	#
	.cfi_def_cfa_offset 64
.L147:
# stencil_template_parallel.c:262: }
	add	rsp, 8	#,
	.cfi_def_cfa_offset 56
	pop	rbx	#
	.cfi_def_cfa_offset 48
	pop	rbp	#
	.cfi_def_cfa_offset 40
	pop	r12	#
	.cfi_def_cfa_offset 32
	pop	r13	#
	.cfi_def_cfa_offset 24
	pop	r14	#
	.cfi_def_cfa_offset 16
	pop	r15	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE68:
	.size	halo_communications, .-halo_communications
	.p2align 4
	.globl	copy_halo
	.type	copy_halo, @function
copy_halo:
.LFB69:
	.cfi_startproc
	endbr64	
	push	r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	mov	r11, rcx	# buffers, tmp158
	mov	r10, rdi	# plane, tmp155
	push	r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# stencil_template_parallel.c:267: {
	mov	rbx, rdx	# N, tmp157
# stencil_template_parallel.c:269:   uint xsize = plane->size[_x_];
	mov	ebp, DWORD PTR 8[rdi]	# xsize, plane_65(D)->size[0]
# stencil_template_parallel.c:275:   if (neighbours[EAST] != MPI_PROC_NULL)
	mov	r12d, DWORD PTR 8[rsi]	# _1, MEM[(int *)neighbours_69(D) + 8B]
# stencil_template_parallel.c:270:   uint ysize = plane->size[_y_];
	mov	r9d, DWORD PTR 12[rdi]	# ysize, plane_65(D)->size[1]
# stencil_template_parallel.c:284:   if (neighbours[WEST] != MPI_PROC_NULL)
	mov	r13d, DWORD PTR 12[rsi]	# pretmp_144, MEM[(int *)neighbours_69(D) + 12B]
# stencil_template_parallel.c:271:   uint fsize = xsize + 2;
	lea	ecx, 2[rbp]	# fsize,
# stencil_template_parallel.c:275:   if (neighbours[EAST] != MPI_PROC_NULL)
	cmp	r12d, -2	# _1,
	je	.L150	#,
# stencil_template_parallel.c:278:     for (uint i = 0; i < ysize; i++)
	test	r9d, r9d	# ysize
	je	.L156	#,
	mov	rsi, QWORD PTR 48[r11]	# ivtmp.385, MEM[(double * restrict[4] *)buffers_70(D) + 32B][2]
	lea	r14d, -1[r9]	# tmp141,
	lea	rax, 8[rsi]	# ivtmp.385,
# stencil_template_parallel.c:280:       plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][EAST][i];
	mov	rdi, QWORD PTR [rdi]	# _6, plane_65(D)->data
	lea	edx, 1[rbp+rcx]	# ivtmp.383,
	lea	r14, [rax+r14*8]	# _101,
	jmp	.L154	#
	.p2align 4,,10
	.p2align 3
.L187:
	add	rax, 8	# ivtmp.385,
.L154:
# stencil_template_parallel.c:280:       plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][EAST][i];
	vmovsd	xmm0, QWORD PTR [rsi]	# _14, MEM[(double *)_107]
# stencil_template_parallel.c:280:       plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][EAST][i];
	mov	esi, edx	# ivtmp.383, ivtmp.383
# stencil_template_parallel.c:280:       plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][EAST][i];
	vmovsd	QWORD PTR [rdi+rsi*8], xmm0	# *_13, _14
# stencil_template_parallel.c:278:     for (uint i = 0; i < ysize; i++)
	add	edx, ecx	# ivtmp.383, fsize
	mov	rsi, rax	# ivtmp.385, ivtmp.385
	cmp	r14, rax	# _101, ivtmp.385
	jne	.L187	#,
# stencil_template_parallel.c:284:   if (neighbours[WEST] != MPI_PROC_NULL)
	cmp	r13d, -2	# pretmp_144,
	je	.L156	#,
.L163:
# stencil_template_parallel.c:289:       plane->data[IDX(0, i + 1)] = buffers[RECV][WEST][i];
	mov	r14, QWORD PTR 56[r11]	# _16, MEM[(double * restrict[4] *)buffers_70(D) + 32B][3]
	mov	edx, ecx	# ivtmp.378, fsize
	xor	eax, eax	# ivtmp.376
	.p2align 4,,10
	.p2align 3
.L157:
# stencil_template_parallel.c:289:       plane->data[IDX(0, i + 1)] = buffers[RECV][WEST][i];
	vmovsd	xmm0, QWORD PTR [r14+rax*8]	# _26, MEM[(double *)_16 + ivtmp.376_120 * 8]
# stencil_template_parallel.c:289:       plane->data[IDX(0, i + 1)] = buffers[RECV][WEST][i];
	mov	esi, edx	# ivtmp.378, ivtmp.378
# stencil_template_parallel.c:287:     for (uint i = 0; i < ysize; i++)
	inc	rax	# ivtmp.376
# stencil_template_parallel.c:289:       plane->data[IDX(0, i + 1)] = buffers[RECV][WEST][i];
	vmovsd	QWORD PTR [rdi+rsi*8], xmm0	# *_25, _26
# stencil_template_parallel.c:287:     for (uint i = 0; i < ysize; i++)
	add	edx, ecx	# ivtmp.378, fsize
	cmp	r9d, eax	# ysize, ivtmp.376
	ja	.L157	#,
.L156:
# stencil_template_parallel.c:293:   if (periodic && N[_x_] == 2)
	test	r8d, r8d	# periodic
	je	.L185	#,
# stencil_template_parallel.c:293:   if (periodic && N[_x_] == 2)
	cmp	DWORD PTR [rbx], 2	# *N_74(D),
	je	.L188	#,
.L185:
# stencil_template_parallel.c:316: }
	pop	rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp	#
	.cfi_def_cfa_offset 32
	pop	r12	#
	.cfi_def_cfa_offset 24
	pop	r13	#
	.cfi_def_cfa_offset 16
	pop	r14	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L150:
	.cfi_restore_state
# stencil_template_parallel.c:284:   if (neighbours[WEST] != MPI_PROC_NULL)
	cmp	r13d, -2	# pretmp_144,
	je	.L156	#,
# stencil_template_parallel.c:287:     for (uint i = 0; i < ysize; i++)
	test	r9d, r9d	# ysize
	je	.L156	#,
# stencil_template_parallel.c:280:       plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][EAST][i];
	mov	rdi, QWORD PTR [rdi]	# _6, plane_65(D)->data
	jmp	.L163	#
	.p2align 4,,10
	.p2align 3
.L188:
# stencil_template_parallel.c:296:     if (neighbours[EAST] == MPI_PROC_NULL)
	cmp	r12d, -2	# _1,
	je	.L189	#,
# stencil_template_parallel.c:305:     if (neighbours[WEST] == MPI_PROC_NULL)
	cmp	r13d, -2	# pretmp_144,
	jne	.L185	#,
# stencil_template_parallel.c:308:       for (uint i = 0; i < ysize; i++)
	test	r9d, r9d	# ysize
	je	.L185	#,
# stencil_template_parallel.c:280:       plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][EAST][i];
	mov	rdi, QWORD PTR [r10]	# _32, plane_65(D)->data
.L162:
# stencil_template_parallel.c:310:         plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][WEST][i];
	mov	r8, QWORD PTR 56[r11]	# _39, MEM[(double * restrict[4] *)buffers_70(D) + 32B][3]
	lea	edx, 1[rbp+rcx]	# ivtmp.367,
	xor	eax, eax	# ivtmp.365
	.p2align 4,,10
	.p2align 3
.L161:
# stencil_template_parallel.c:310:         plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][WEST][i];
	vmovsd	xmm0, QWORD PTR [r8+rax*8]	# _51, MEM[(double *)_39 + ivtmp.365_63 * 8]
# stencil_template_parallel.c:310:         plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][WEST][i];
	mov	esi, edx	# ivtmp.367, ivtmp.367
# stencil_template_parallel.c:308:       for (uint i = 0; i < ysize; i++)
	inc	rax	# ivtmp.365
# stencil_template_parallel.c:310:         plane->data[IDX(xsize + 1, i + 1)] = buffers[RECV][WEST][i];
	vmovsd	QWORD PTR [rdi+rsi*8], xmm0	# *_50, _51
# stencil_template_parallel.c:308:       for (uint i = 0; i < ysize; i++)
	add	edx, ecx	# ivtmp.367, fsize
	cmp	r9d, eax	# ysize, ivtmp.365
	ja	.L161	#,
	jmp	.L185	#
.L189:
# stencil_template_parallel.c:299:       for (uint i = 0; i < ysize; i++)
	test	r9d, r9d	# ysize
	je	.L185	#,
	mov	rsi, QWORD PTR 48[r11]	# ivtmp.374, MEM[(double * restrict[4] *)buffers_70(D) + 32B][2]
	lea	edx, -1[r9]	# tmp147,
	lea	rax, 8[rsi]	# ivtmp.374,
	lea	r8, [rax+rdx*8]	# _121,
# stencil_template_parallel.c:301:         plane->data[IDX(0, i + 1)] = buffers[RECV][EAST][i];
	mov	rdi, QWORD PTR [r10]	# _32, plane_65(D)->data
	mov	edx, ecx	# ivtmp.373, fsize
	jmp	.L159	#
	.p2align 4,,10
	.p2align 3
.L190:
	add	rax, 8	# ivtmp.374,
.L159:
# stencil_template_parallel.c:301:         plane->data[IDX(0, i + 1)] = buffers[RECV][EAST][i];
	vmovsd	xmm0, QWORD PTR [rsi]	# _38, MEM[(double *)_129]
# stencil_template_parallel.c:301:         plane->data[IDX(0, i + 1)] = buffers[RECV][EAST][i];
	mov	esi, edx	# ivtmp.373, ivtmp.373
# stencil_template_parallel.c:301:         plane->data[IDX(0, i + 1)] = buffers[RECV][EAST][i];
	vmovsd	QWORD PTR [rdi+rsi*8], xmm0	# *_37, _38
# stencil_template_parallel.c:299:       for (uint i = 0; i < ysize; i++)
	add	edx, ecx	# ivtmp.373, fsize
	mov	rsi, rax	# ivtmp.374, ivtmp.374
	cmp	r8, rax	# _121, ivtmp.374
	jne	.L190	#,
# stencil_template_parallel.c:305:     if (neighbours[WEST] == MPI_PROC_NULL)
	cmp	r13d, -2	# pretmp_144,
	jne	.L185	#,
	jmp	.L162	#
	.cfi_endproc
.LFE69:
	.size	copy_halo, .-copy_halo
	.p2align 4
	.globl	update_inner_points
	.type	update_inner_points, @function
update_inner_points:
.LFB71:
	.cfi_startproc
	endbr64	
	sub	rsp, 56	#,
	.cfi_def_cfa_offset 64
# stencil_template_parallel.c:327:   const uint xsize = oldplane->size[_x_];
	vmovq	xmm1, QWORD PTR 8[rdi]	# vect_xsize_3.391, MEM <const vector(2) unsigned int> [(unsigned int *)oldplane_2(D) + 8B]
# stencil_template_parallel.c:336: #pragma omp parallel for collapse(2) schedule(static)
	vmovq	xmm0, QWORD PTR [rdi]	# oldplane_2(D)->data, oldplane_2(D)->data
# stencil_template_parallel.c:325: {
	mov	rax, QWORD PTR fs:40	# tmp105, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR 40[rsp], rax	# D.14110, tmp105
	xor	eax, eax	# tmp105
# stencil_template_parallel.c:336: #pragma omp parallel for collapse(2) schedule(static)
	vpinsrq	xmm0, xmm0, QWORD PTR [rsi], 1	# tmp94, oldplane_2(D)->data, newplane_7(D)->data
# stencil_template_parallel.c:329:   const uint fxsize = xsize + 2; // including halos
	vmovd	eax, xmm1	# tmp97, vect_xsize_3.391
	add	eax, 2	# tmp98,
	xor	ecx, ecx	#
	xor	edx, edx	#
	mov	rsi, rsp	# tmp99,
	lea	rdi, update_inner_points._omp_fn.0[rip]	# tmp100,
	mov	DWORD PTR 24[rsp], eax	# .omp_data_o.70.fxsize, tmp98
# stencil_template_parallel.c:336: #pragma omp parallel for collapse(2) schedule(static)
	vmovdqa	XMMWORD PTR [rsp], xmm0	# MEM <vector(2) long unsigned int> [(double * *)&.omp_data_o.70], tmp94
	vmovq	QWORD PTR 16[rsp], xmm1	# MEM <const vector(2) unsigned int> [(unsigned int *)&.omp_data_o.70 + 16B], vect_xsize_3.391
	call	GOMP_parallel@PLT	#
# stencil_template_parallel.c:347: }
	mov	rax, QWORD PTR 40[rsp]	# tmp106, D.14110
	sub	rax, QWORD PTR fs:40	# tmp106, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L194	#,
	xor	eax, eax	#
	add	rsp, 56	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
.L194:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE71:
	.size	update_inner_points, .-update_inner_points
	.p2align 4
	.globl	update_boundary_points
	.type	update_boundary_points, @function
update_boundary_points:
.LFB72:
	.cfi_startproc
	endbr64	
	push	r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	mov	r14d, edx	# periodic, tmp162
	xor	edx, edx	#
	push	r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rcx	# N, tmp163
	xor	ecx, ecx	#
	push	r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 88	#,
	.cfi_def_cfa_offset 144
# stencil_template_parallel.c:350: {
	mov	rax, QWORD PTR fs:40	# tmp164, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR 72[rsp], rax	# D.14161, tmp164
	xor	eax, eax	# tmp164
# stencil_template_parallel.c:352:   const uint xsize = oldplane->size[_x_];
	vmovq	xmm0, QWORD PTR 8[rdi]	# vect_xsize_49.405, MEM <const vector(2) unsigned int> [(unsigned int *)oldplane_48(D) + 8B]
# stencil_template_parallel.c:359:   double *restrict old = oldplane->data;
	mov	rax, QWORD PTR [rdi]	# old, oldplane_48(D)->data
# stencil_template_parallel.c:360:   double *restrict new = newplane->data;
	mov	rbx, QWORD PTR [rsi]	# new, newplane_53(D)->data
	vmovd	r12d, xmm0	# _133, vect_xsize_49.405
# stencil_template_parallel.c:363: #pragma omp parallel for schedule(static)
	vmovq	xmm2, rax	# old, old
	lea	rsi, 32[rsp]	# tmp138,
# stencil_template_parallel.c:354:   const uint fxsize = xsize + 2; // including halos
	lea	ebp, 2[r12]	# fxsize,
# stencil_template_parallel.c:363: #pragma omp parallel for schedule(static)
	vpinsrq	xmm1, xmm2, rbx, 1	# tmp137, old, new
	lea	rdi, update_boundary_points._omp_fn.0[rip]	# tmp139,
	mov	QWORD PTR 24[rsp], rax	# %sfp, old
	mov	QWORD PTR 8[rsp], rsi	# %sfp, tmp138
	vpextrd	r15d, xmm0, 1	# _132, vect_xsize_49.405
	vmovq	QWORD PTR 48[rsp], xmm0	# MEM <const vector(2) unsigned int> [(unsigned int *)_49], vect_xsize_49.405
	vmovq	QWORD PTR 16[rsp], xmm0	# %sfp, vect_xsize_49.405
	mov	DWORD PTR 56[rsp], ebp	# MEM[(struct .omp_data_s.76 *)_49].fxsize, fxsize
	vmovdqa	XMMWORD PTR 32[rsp], xmm1	# MEM <vector(2) long unsigned int> [(double * *)_49], tmp137
	call	GOMP_parallel@PLT	#
# stencil_template_parallel.c:371: #pragma omp parallel for schedule(static)
	mov	rax, QWORD PTR 24[rsp]	# old, %sfp
	vmovq	xmm0, QWORD PTR 16[rsp]	# vect_xsize_49.405, %sfp
	mov	rsi, QWORD PTR 8[rsp]	# tmp138, %sfp
	xor	ecx, ecx	#
	xor	edx, edx	#
	lea	rdi, update_boundary_points._omp_fn.1[rip]	# tmp141,
	mov	QWORD PTR 40[rsp], rbx	# MEM[(struct .omp_data_s.77 *)_49].new, new
	mov	QWORD PTR 32[rsp], rax	# MEM[(struct .omp_data_s.77 *)_49].old, old
	mov	DWORD PTR 56[rsp], ebp	# MEM[(struct .omp_data_s.77 *)_49].fxsize, fxsize
	vmovq	QWORD PTR 48[rsp], xmm0	# MEM <const vector(2) unsigned int> [(unsigned int *)_49], vect_xsize_49.405
	call	GOMP_parallel@PLT	#
# stencil_template_parallel.c:378:   if (periodic)
	test	r14d, r14d	# periodic
	je	.L196	#,
# stencil_template_parallel.c:380:     if (N[_x_] == 1)
	mov	edx, DWORD PTR 0[r13]	# r, *N_70(D)
# stencil_template_parallel.c:380:     if (N[_x_] == 1)
	cmp	edx, 1	# r,
	je	.L213	#,
.L197:
# stencil_template_parallel.c:393:     if (N[_y_] == 1)
	mov	eax, DWORD PTR 4[r13]	# c, MEM[(uint *)N_70(D) + 4B]
# stencil_template_parallel.c:393:     if (N[_y_] == 1)
	cmp	eax, 1	# c,
	je	.L214	#,
.L196:
# stencil_template_parallel.c:408: }
	mov	rax, QWORD PTR 72[rsp]	# tmp165, D.14161
	sub	rax, QWORD PTR fs:40	# tmp165, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L215	#,
	add	rsp, 88	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx	#
	.cfi_def_cfa_offset 48
	pop	rbp	#
	.cfi_def_cfa_offset 40
	pop	r12	#
	.cfi_def_cfa_offset 32
	pop	r13	#
	.cfi_def_cfa_offset 24
	pop	r14	#
	.cfi_def_cfa_offset 16
	xor	eax, eax	#
	pop	r15	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L214:
	.cfi_restore_state
# stencil_template_parallel.c:398:       for (uint c = 1; c <= xsize; c++)
	test	r12d, r12d	# _133
	je	.L196	#,
# stencil_template_parallel.c:401:         new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	imul	r15d, ebp	# _21, fxsize
# stencil_template_parallel.c:402:         new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	lea	ecx, [r15+rbp]	# _35,
	.p2align 4,,10
	.p2align 3
.L199:
# stencil_template_parallel.c:401:         new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	lea	edx, [r15+rax]	# tmp151,
# stencil_template_parallel.c:401:         new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	vmovsd	xmm0, QWORD PTR [rbx+rdx*8]	# _29, *_25
# stencil_template_parallel.c:401:         new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	mov	edx, eax	# c, c
# stencil_template_parallel.c:401:         new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	vmovsd	QWORD PTR [rbx+rdx*8], xmm0	# *_28, _29
# stencil_template_parallel.c:402:         new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	lea	edx, 0[rbp+rax]	# tmp154,
# stencil_template_parallel.c:402:         new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	vmovsd	xmm0, QWORD PTR [rbx+rdx*8]	# _40, *_33
# stencil_template_parallel.c:402:         new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	lea	edx, [rcx+rax]	# tmp156,
# stencil_template_parallel.c:398:       for (uint c = 1; c <= xsize; c++)
	inc	eax	# c
# stencil_template_parallel.c:402:         new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	vmovsd	QWORD PTR [rbx+rdx*8], xmm0	# *_39, _40
# stencil_template_parallel.c:398:       for (uint c = 1; c <= xsize; c++)
	cmp	eax, r12d	# c, _133
	jbe	.L199	#,
	jmp	.L196	#
	.p2align 4,,10
	.p2align 3
.L213:
# stencil_template_parallel.c:385:       for (uint r = 1; r <= ysize; r++)
	test	r15d, r15d	# _132
	je	.L197	#,
# stencil_template_parallel.c:354:   const uint fxsize = xsize + 2; // including halos
	mov	eax, ebp	# ivtmp.425, fxsize
	lea	esi, 1[r12]	# tmp159,
	.p2align 4,,10
	.p2align 3
.L198:
# stencil_template_parallel.c:388:         new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	lea	ecx, [r12+rax]	# tmp143,
# stencil_template_parallel.c:388:         new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	vmovsd	xmm0, QWORD PTR [rbx+rcx*8]	# _10, *_6
# stencil_template_parallel.c:388:         new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	mov	ecx, eax	# ivtmp.425, ivtmp.425
# stencil_template_parallel.c:388:         new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	vmovsd	QWORD PTR [rbx+rcx*8], xmm0	# *_9, _10
# stencil_template_parallel.c:389:         new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	lea	ecx, 1[rax]	# tmp146,
# stencil_template_parallel.c:389:         new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	vmovsd	xmm0, QWORD PTR [rbx+rcx*8]	# _19, *_14
# stencil_template_parallel.c:385:       for (uint r = 1; r <= ysize; r++)
	inc	edx	# r
# stencil_template_parallel.c:389:         new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	lea	ecx, [rsi+rax]	# tmp149,
# stencil_template_parallel.c:389:         new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	vmovsd	QWORD PTR [rbx+rcx*8], xmm0	# *_18, _19
# stencil_template_parallel.c:385:       for (uint r = 1; r <= ysize; r++)
	add	eax, ebp	# ivtmp.425, fxsize
	cmp	edx, r15d	# r, _132
	jbe	.L198	#,
# stencil_template_parallel.c:393:     if (N[_y_] == 1)
	mov	eax, DWORD PTR 4[r13]	# c, MEM[(uint *)N_70(D) + 4B]
# stencil_template_parallel.c:393:     if (N[_y_] == 1)
	cmp	eax, 1	# c,
	jne	.L196	#,
	jmp	.L214	#
.L215:
# stencil_template_parallel.c:408: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE72:
	.size	update_boundary_points, .-update_boundary_points
	.p2align 4
	.globl	simple_factorization
	.type	simple_factorization, @function
simple_factorization:
.LFB74:
	.cfi_startproc
	endbr64	
	push	r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	mov	r12, rdx	# factors, tmp135
	push	rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# stencil_template_parallel.c:742:   while (f < A)
	cmp	edi, 2	# A,
	jbe	.L217	#,
	mov	ebx, edi	# A, tmp133
	mov	ecx, edi	# _A_, A
# stencil_template_parallel.c:739:   int f = 2;
	mov	ebp, 2	# f,
# stencil_template_parallel.c:738:   int N = 0;
	xor	edi, edi	# N
	.p2align 4,,10
	.p2align 3
.L218:
# stencil_template_parallel.c:744:     while (_A_ % f == 0)
	mov	eax, ecx	# tmp115, _A_
	xor	edx, edx	# tmp114
	div	ebp	# f
# stencil_template_parallel.c:744:     while (_A_ % f == 0)
	test	edx, edx	# tmp114
	jne	.L221	#,
	.p2align 4,,10
	.p2align 3
.L219:
# stencil_template_parallel.c:747:       _A_ /= f;
	mov	eax, ecx	# _A_, _A_
	xor	edx, edx	# tmp106
	div	ebp	# f
# stencil_template_parallel.c:744:     while (_A_ % f == 0)
	xor	edx, edx	# tmp108
# stencil_template_parallel.c:746:       N++;
	inc	edi	# N
# stencil_template_parallel.c:747:       _A_ /= f;
	mov	ecx, eax	# _A_, _A_
# stencil_template_parallel.c:744:     while (_A_ % f == 0)
	div	ebp	# f
# stencil_template_parallel.c:744:     while (_A_ % f == 0)
	test	edx, edx	# tmp108
	je	.L219	#,
.L221:
# stencil_template_parallel.c:750:     f++;
	lea	eax, 1[rbp]	# f,
# stencil_template_parallel.c:742:   while (f < A)
	cmp	ebx, eax	# A, f
	je	.L220	#,
	mov	ebp, eax	# f, f
	jmp	.L218	#
	.p2align 4,,10
	.p2align 3
.L220:
# stencil_template_parallel.c:753:   *Nfactors = N;
	mov	DWORD PTR [rsi], edi	# *Nfactors_29(D), N
# stencil_template_parallel.c:754:   uint *_factors_ = (uint *)malloc(N * sizeof(uint));
	movsx	rdi, edi	# N, N
	sal	rdi, 2	# tmp130,
	call	malloc@PLT	#
	mov	r8, rax	# _factors_, tmp136
	mov	ecx, 2	# f,
	xor	edi, edi	# N
	.p2align 4,,10
	.p2align 3
.L226:
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	mov	eax, ebx	# tmp127, A
	xor	edx, edx	# tmp126
	div	ecx	# f
	lea	esi, 1[rdi]	# tmp116,
	movsx	rsi, esi	# ivtmp.438, tmp116
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	test	edx, edx	# tmp126
	jne	.L225	#,
	.p2align 4,,10
	.p2align 3
.L222:
# stencil_template_parallel.c:765:       _A_ /= f;
	mov	eax, ebx	# A, A
	xor	edx, edx	# tmp118
	div	ecx	# f
# stencil_template_parallel.c:764:       _factors_[N++] = f;
	mov	DWORD PTR -4[r8+rsi*4], ecx	# MEM[(uint *)_factors__26 + -4B + ivtmp.438_57 * 4], f
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	xor	edx, edx	# tmp120
# stencil_template_parallel.c:764:       _factors_[N++] = f;
	mov	edi, esi	# N, ivtmp.438
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	inc	rsi	# ivtmp.438
# stencil_template_parallel.c:765:       _A_ /= f;
	mov	ebx, eax	# A, A
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	div	ecx	# f
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	test	edx, edx	# tmp120
	je	.L222	#,
.L225:
# stencil_template_parallel.c:767:     f++;
	lea	eax, 1[rcx]	# f,
# stencil_template_parallel.c:760:   while (f < A)
	cmp	ebp, ecx	# f, f
	je	.L223	#,
	mov	ecx, eax	# f, f
	jmp	.L226	#
.L217:
# stencil_template_parallel.c:753:   *Nfactors = N;
	mov	DWORD PTR [rsi], 0	# *Nfactors_29(D),
# stencil_template_parallel.c:754:   uint *_factors_ = (uint *)malloc(N * sizeof(uint));
	xor	edi, edi	#
	call	malloc@PLT	#
	mov	r8, rax	# _factors_, tmp137
.L223:
# stencil_template_parallel.c:772: }
	pop	rbx	#
	.cfi_def_cfa_offset 24
	pop	rbp	#
	.cfi_def_cfa_offset 16
# stencil_template_parallel.c:770:   *factors = _factors_;
	mov	QWORD PTR [r12], r8	# *factors_33(D), _factors_
# stencil_template_parallel.c:772: }
	xor	eax, eax	#
	pop	r12	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE74:
	.size	simple_factorization, .-simple_factorization
	.p2align 4
	.globl	initialize_sources
	.type	initialize_sources, @function
initialize_sources:
.LFB75:
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	push	r15	#
	.cfi_offset 15, -24
	mov	r15d, edi	# Me, tmp243
# stencil_template_parallel.c:784:   srand48(time(NULL) ^ Me);
	xor	edi, edi	#
# stencil_template_parallel.c:782: {
	push	r14	#
	.cfi_offset 14, -32
	mov	r14, rcx	# mysize, tmp246
	push	r13	#
	.cfi_offset 13, -40
	mov	r13d, r8d	# Nsources, tmp247
	push	r12	#
	push	rbx	#
	and	rsp, -32	#,
	sub	rsp, 32	#,
	.cfi_offset 12, -48
	.cfi_offset 3, -56
# stencil_template_parallel.c:782: {
	mov	DWORD PTR 28[rsp], esi	# %sfp, tmp244
	mov	QWORD PTR 8[rsp], rdx	# %sfp, tmp245
	mov	QWORD PTR [rsp], r9	# %sfp, tmp248
# stencil_template_parallel.c:784:   srand48(time(NULL) ^ Me);
	call	time@PLT	#
# stencil_template_parallel.c:784:   srand48(time(NULL) ^ Me);
	movsx	rdi, r15d	# Me, Me
	xor	rdi, rax	# tmp181, tmp249
	call	srand48@PLT	#
# stencil_template_parallel.c:785:   int *tasks_with_sources = (int *)malloc(Nsources * sizeof(int));
	movsx	rdi, r13d	# Nsources, Nsources
	sal	rdi, 2	# tmp183,
	call	malloc@PLT	#
	mov	r12, rax	# tasks_with_sources, tmp250
# stencil_template_parallel.c:787:   if (Me == 0)
	test	r15d, r15d	# Me
	jne	.L239	#,
# stencil_template_parallel.c:789:     for (int i = 0; i < Nsources; i++)
	test	r13d, r13d	# Nsources
	jle	.L240	#,
	mov	rbx, rax	# ivtmp.501, tasks_with_sources
	mov	eax, r13d	# Nsources, Nsources
	lea	rax, [r12+rax*4]	# _141,
	mov	QWORD PTR 16[rsp], rax	# %sfp, _141
	.p2align 4,,10
	.p2align 3
.L241:
# stencil_template_parallel.c:790:       tasks_with_sources[i] = (int)lrand48() % Ntasks;
	call	lrand48@PLT	#
# stencil_template_parallel.c:790:       tasks_with_sources[i] = (int)lrand48() % Ntasks;
	cdq
	idiv	DWORD PTR 28[rsp]	# %sfp
# stencil_template_parallel.c:789:     for (int i = 0; i < Nsources; i++)
	add	rbx, 4	# ivtmp.501,
# stencil_template_parallel.c:790:       tasks_with_sources[i] = (int)lrand48() % Ntasks;
	mov	DWORD PTR -4[rbx], edx	# MEM[(int *)_166], tmp188
# stencil_template_parallel.c:789:     for (int i = 0; i < Nsources; i++)
	cmp	rbx, QWORD PTR 16[rsp]	# ivtmp.501, %sfp
	jne	.L241	#,
# stencil_template_parallel.c:793:   MPI_Bcast(tasks_with_sources, Nsources, MPI_INT, 0, *Comm);
	mov	rax, QWORD PTR 8[rsp]	# Comm, %sfp
	xor	ecx, ecx	#
	mov	r8, QWORD PTR [rax]	#, *Comm_56(D)
	lea	rdx, ompi_mpi_int[rip]	# tmp242,
	mov	esi, r13d	#, Nsources
	mov	rdi, r12	#, tasks_with_sources
	call	MPI_Bcast@PLT	#
.L251:
	test	r13d, r13d	# Nsources
	mov	ecx, 1	# tmp192,
	cmovg	ecx, r13d	# Nsources,, tmp192
	cmp	r13d, 7	# Nsources,
	jle	.L252	#,
	mov	edx, ecx	# bnd.461, niters.460
	shr	edx, 3	#,
	sal	rdx, 5	# tmp196,
	vpbroadcastd	ymm2, r15d	# vect_cst__110, Me
	mov	rax, r12	# ivtmp.494, tasks_with_sources
	add	rdx, r12	# _97, tasks_with_sources
# stencil_template_parallel.c:782: {
	vpxor	xmm0, xmm0, xmm0	# vect_nlocal_71.470
	.p2align 4,,10
	.p2align 3
.L245:
	vpcmpeqd	ymm1, ymm2, YMMWORD PTR [rax]	# tmp198, vect_cst__110, MEM <vector(8) int> [(int *)_143]
	add	rax, 32	# ivtmp.494,
# stencil_template_parallel.c:797:     nlocal += (tasks_with_sources[i] == Me);
	vpsubd	ymm0, ymm0, ymm1	# vect_nlocal_71.470, vect_nlocal_71.470, tmp198
	cmp	rdx, rax	# _97, ivtmp.494
	jne	.L245	#,
	vmovdqa	xmm1, xmm0	# tmp199, vect_nlocal_71.470
	vextracti128	xmm0, ymm0, 0x1	# tmp200, vect_nlocal_71.470
	vpaddd	xmm0, xmm1, xmm0	# _119, tmp199, tmp200
	vpsrldq	xmm1, xmm0, 8	# tmp202, _119,
	vpaddd	xmm0, xmm0, xmm1	# _121, _119, tmp202
	vpsrldq	xmm1, xmm0, 4	# tmp204, _121,
	mov	eax, ecx	# niters_vector_mult_vf.462, niters.460
	vpaddd	xmm0, xmm0, xmm1	# tmp205, _121, tmp204
	and	eax, -8	#,
	vmovd	ebx, xmm0	# stmp_nlocal_71.471, tmp205
	mov	esi, eax	# tmp.475, niters_vector_mult_vf.462
	cmp	eax, ecx	# niters_vector_mult_vf.462, niters.460
	je	.L263	#,
	vzeroupper
.L244:
	sub	ecx, eax	# niters.460, niters_vector_mult_vf.462
	mov	edx, ecx	# niters.472, niters.460
	lea	ecx, -1[rcx]	# tmp206,
	cmp	ecx, 2	# tmp206,
	jbe	.L247	#,
	vpbroadcastd	xmm0, r15d	# tmp209, Me
	vpcmpeqd	xmm0, xmm0, XMMWORD PTR [r12+rax*4]	# tmp211, tmp209, MEM <vector(4) int> [(int *)vectp_tasks_with_sources.478_154]
	vpandd	xmm0, xmm0, DWORD PTR .LC5[rip]{1to4}	# vect_patt_101.481, tmp211,
	vpsrldq	xmm1, xmm0, 8	# tmp213, vect_patt_101.481,
	vpaddd	xmm0, xmm0, xmm1	# _168, vect_patt_101.481, tmp213
	vpsrldq	xmm1, xmm0, 4	# tmp215, _168,
	vpaddd	xmm0, xmm0, xmm1	# tmp216, _168, tmp215
	vmovd	eax, xmm0	# stmp_nlocal_90.483, tmp216
	add	ebx, eax	# stmp_nlocal_71.471, stmp_nlocal_90.483
	mov	eax, edx	# niters_vector_mult_vf.474, niters.472
	and	eax, -4	# niters_vector_mult_vf.474,
	add	esi, eax	# tmp.475, niters_vector_mult_vf.474
	cmp	edx, eax	# niters.472, niters_vector_mult_vf.474
	je	.L246	#,
.L247:
# stencil_template_parallel.c:797:     nlocal += (tasks_with_sources[i] == Me);
	movsx	rax, esi	# tmp.475, tmp.475
# stencil_template_parallel.c:797:     nlocal += (tasks_with_sources[i] == Me);
	cmp	DWORD PTR [r12+rax*4], r15d	# *_15, Me
# stencil_template_parallel.c:797:     nlocal += (tasks_with_sources[i] == Me);
	lea	rdx, 0[0+rax*4]	# _14,
# stencil_template_parallel.c:797:     nlocal += (tasks_with_sources[i] == Me);
	sete	al	#, tmp219
	movzx	eax, al	# tmp219, tmp219
# stencil_template_parallel.c:797:     nlocal += (tasks_with_sources[i] == Me);
	add	ebx, eax	# stmp_nlocal_71.471, tmp219
# stencil_template_parallel.c:796:   for (int i = 0; i < Nsources; i++)
	lea	eax, 1[rsi]	# i,
# stencil_template_parallel.c:796:   for (int i = 0; i < Nsources; i++)
	cmp	r13d, eax	# Nsources, i
	jle	.L246	#,
# stencil_template_parallel.c:797:     nlocal += (tasks_with_sources[i] == Me);
	xor	eax, eax	# tmp222
	cmp	DWORD PTR 4[r12+rdx], r15d	# *_94, Me
	sete	al	#, tmp222
# stencil_template_parallel.c:796:   for (int i = 0; i < Nsources; i++)
	add	esi, 2	# i,
# stencil_template_parallel.c:797:     nlocal += (tasks_with_sources[i] == Me);
	add	ebx, eax	# stmp_nlocal_71.471, tmp222
# stencil_template_parallel.c:796:   for (int i = 0; i < Nsources; i++)
	cmp	r13d, esi	# Nsources, i
	jle	.L246	#,
# stencil_template_parallel.c:797:     nlocal += (tasks_with_sources[i] == Me);
	xor	eax, eax	# tmp225
	cmp	DWORD PTR 8[r12+rdx], r15d	# *_135, Me
	sete	al	#, tmp225
# stencil_template_parallel.c:797:     nlocal += (tasks_with_sources[i] == Me);
	add	ebx, eax	# stmp_nlocal_71.471, tmp225
.L246:
# stencil_template_parallel.c:798:   *Nsources_local = nlocal;
	mov	rax, QWORD PTR [rsp]	# Nsources_local, %sfp
	mov	DWORD PTR [rax], ebx	# *Nsources_local_58(D), stmp_nlocal_71.471
# stencil_template_parallel.c:800:   if (nlocal > 0)
	test	ebx, ebx	# stmp_nlocal_71.471
	jne	.L264	#,
.L249:
# stencil_template_parallel.c:812:   free(tasks_with_sources);
	mov	rdi, r12	#, tasks_with_sources
	call	free@PLT	#
# stencil_template_parallel.c:815: }
	lea	rsp, -40[rbp]	#,
	pop	rbx	#
	pop	r12	#
	pop	r13	#
	pop	r14	#
	pop	r15	#
	xor	eax, eax	#
	pop	rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
	.p2align 4,,10
	.p2align 3
.L239:
	.cfi_restore_state
# stencil_template_parallel.c:793:   MPI_Bcast(tasks_with_sources, Nsources, MPI_INT, 0, *Comm);
	mov	rax, QWORD PTR 8[rsp]	# Comm, %sfp
	xor	ecx, ecx	#
	mov	r8, QWORD PTR [rax]	#, *Comm_56(D)
	lea	rdx, ompi_mpi_int[rip]	# tmp190,
	mov	esi, r13d	#, Nsources
	mov	rdi, r12	#, tasks_with_sources
	call	MPI_Bcast@PLT	#
# stencil_template_parallel.c:796:   for (int i = 0; i < Nsources; i++)
	test	r13d, r13d	# Nsources
	jg	.L251	#,
.L243:
# stencil_template_parallel.c:798:   *Nsources_local = nlocal;
	mov	rax, QWORD PTR [rsp]	# Nsources_local, %sfp
	mov	DWORD PTR [rax], 0	# *Nsources_local_58(D),
	jmp	.L249	#
	.p2align 4,,10
	.p2align 3
.L264:
# stencil_template_parallel.c:802:     vec2_t *restrict helper = (vec2_t *)malloc(nlocal * sizeof(vec2_t));
	movsx	rdi, ebx	# stmp_nlocal_71.471, stmp_nlocal_71.471
	sal	rdi, 3	# tmp228,
	call	malloc@PLT	#
	mov	r15, rax	# helper, tmp252
	xor	r13d, r13d	# ivtmp.486
	.p2align 4,,10
	.p2align 3
.L250:
# stencil_template_parallel.c:805:       helper[s][_x_] = 1 + lrand48() % mysize[_x_];
	call	lrand48@PLT	#
# stencil_template_parallel.c:805:       helper[s][_x_] = 1 + lrand48() % mysize[_x_];
	mov	ecx, DWORD PTR [r14]	# *mysize_65(D), *mysize_65(D)
# stencil_template_parallel.c:805:       helper[s][_x_] = 1 + lrand48() % mysize[_x_];
	cqo
	idiv	rcx	# *mysize_65(D)
# stencil_template_parallel.c:805:       helper[s][_x_] = 1 + lrand48() % mysize[_x_];
	inc	edx	# tmp234
	mov	DWORD PTR [r15+r13*8], edx	# MEM[(unsigned int *)helper_61 + ivtmp.486_112 * 8], tmp234
# stencil_template_parallel.c:806:       helper[s][_y_] = 1 + lrand48() % mysize[_y_];
	call	lrand48@PLT	#
# stencil_template_parallel.c:806:       helper[s][_y_] = 1 + lrand48() % mysize[_y_];
	mov	ecx, DWORD PTR 4[r14]	# MEM[(uint *)mysize_65(D) + 4B], MEM[(uint *)mysize_65(D) + 4B]
# stencil_template_parallel.c:806:       helper[s][_y_] = 1 + lrand48() % mysize[_y_];
	cqo
	idiv	rcx	# MEM[(uint *)mysize_65(D) + 4B]
# stencil_template_parallel.c:806:       helper[s][_y_] = 1 + lrand48() % mysize[_y_];
	inc	edx	# tmp239
	mov	DWORD PTR 4[r15+r13*8], edx	# MEM[(unsigned int *)helper_61 + 4B + ivtmp.486_112 * 8], tmp239
# stencil_template_parallel.c:803:     for (int s = 0; s < nlocal; s++)
	inc	r13	# ivtmp.486
	cmp	ebx, r13d	# stmp_nlocal_71.471, ivtmp.486
	jg	.L250	#,
# stencil_template_parallel.c:809:     *Sources = helper;
	mov	rax, QWORD PTR 16[rbp]	# Sources, Sources
	mov	QWORD PTR [rax], r15	# *Sources_62(D), helper
	jmp	.L249	#
.L240:
# stencil_template_parallel.c:793:   MPI_Bcast(tasks_with_sources, Nsources, MPI_INT, 0, *Comm);
	mov	rax, QWORD PTR 8[rsp]	# Comm, %sfp
	xor	ecx, ecx	#
	mov	r8, QWORD PTR [rax]	#, *Comm_56(D)
	lea	rdx, ompi_mpi_int[rip]	# tmp241,
	mov	esi, r13d	#, Nsources
	mov	rdi, r12	#, tasks_with_sources
	call	MPI_Bcast@PLT	#
	jmp	.L243	#
	.p2align 4,,10
	.p2align 3
.L263:
	vzeroupper
# stencil_template_parallel.c:798:   *Nsources_local = nlocal;
	mov	rax, QWORD PTR [rsp]	# Nsources_local, %sfp
	mov	DWORD PTR [rax], ebx	# *Nsources_local_58(D), stmp_nlocal_71.471
# stencil_template_parallel.c:800:   if (nlocal > 0)
	test	ebx, ebx	# stmp_nlocal_71.471
	je	.L249	#,
	jmp	.L264	#
.L252:
# stencil_template_parallel.c:782: {
	xor	eax, eax	#
	xor	esi, esi	# tmp.475
	xor	ebx, ebx	# stmp_nlocal_71.471
	jmp	.L244	#
	.cfi_endproc
.LFE75:
	.size	initialize_sources, .-initialize_sources
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC6:
	.string	"error :: planes_ptr is NULL\n"
.LC7:
	.string	"error :: buffers_ptr is NULL\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC8:
	.string	"error :: malloc failed for planes_ptr[OLD].data\n"
	.align 8
.LC9:
	.string	"error :: malloc failed for planes_ptr[NEW].data\n"
	.align 8
.LC10:
	.string	"error :: malloc failed for SEND EAST buffer\n"
	.align 8
.LC11:
	.string	"error :: malloc failed for RECV EAST buffer\n"
	.align 8
.LC12:
	.string	"error :: malloc failed for SEND WEST buffer\n"
	.align 8
.LC13:
	.string	"error :: malloc failed for RECV WEST buffer\n"
	.text
	.p2align 4
	.globl	memory_allocate
	.type	memory_allocate, @function
memory_allocate:
.LFB76:
	.cfi_startproc
	endbr64	
	push	r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# stencil_template_parallel.c:862:   if (planes_ptr == NULL)
	test	rcx, rcx	# planes_ptr
	je	.L277	#,
	mov	r12, rdx	# buffers_ptr, tmp153
# stencil_template_parallel.c:870:   if (buffers_ptr == NULL)
	test	rdx, rdx	# buffers_ptr
	je	.L278	#,
# stencil_template_parallel.c:882:   unsigned int frame_size = (planes_ptr[OLD].size[_x_] + 2) * (planes_ptr[OLD].size[_y_] + 2);
	mov	eax, DWORD PTR 8[rcx]	# tmp162, planes_ptr_34(D)->size[0]
# stencil_template_parallel.c:882:   unsigned int frame_size = (planes_ptr[OLD].size[_x_] + 2) * (planes_ptr[OLD].size[_y_] + 2);
	mov	r14d, DWORD PTR 12[rcx]	#, planes_ptr_34(D)->size[1]
# stencil_template_parallel.c:882:   unsigned int frame_size = (planes_ptr[OLD].size[_x_] + 2) * (planes_ptr[OLD].size[_y_] + 2);
	lea	ebp, 2[rax]	# tmp122,
# stencil_template_parallel.c:882:   unsigned int frame_size = (planes_ptr[OLD].size[_x_] + 2) * (planes_ptr[OLD].size[_y_] + 2);
	lea	eax, 2[r14]	# tmp124,
# stencil_template_parallel.c:884:   planes_ptr[OLD].data = (double *)malloc(frame_size * sizeof(double));
	imul	ebp, eax	# frame_size, tmp124
	mov	r13, rdi	# neighbours, tmp152
	mov	esi, 1	#,
	sal	rbp, 3	# _8,
	mov	rdi, rbp	#, _8
	mov	rbx, rcx	# planes_ptr, tmp154
	call	calloc@PLT	#
# stencil_template_parallel.c:884:   planes_ptr[OLD].data = (double *)malloc(frame_size * sizeof(double));
	mov	QWORD PTR [rbx], rax	# planes_ptr_34(D)->data, tmp127
# stencil_template_parallel.c:885:   if (planes_ptr[OLD].data == NULL)
	test	rax, rax	# tmp127
	je	.L279	#,
# stencil_template_parallel.c:893:   planes_ptr[NEW].data = (double *)malloc(frame_size * sizeof(double));
	mov	esi, 1	#,
	mov	rdi, rbp	#, _8
	call	calloc@PLT	#
# stencil_template_parallel.c:893:   planes_ptr[NEW].data = (double *)malloc(frame_size * sizeof(double));
	mov	QWORD PTR 16[rbx], rax	# MEM[(struct plane_t *)planes_ptr_34(D) + 16B].data, tmp130
# stencil_template_parallel.c:894:   if (planes_ptr[NEW].data == NULL)
	test	rax, rax	# tmp130
	je	.L280	#,
# stencil_template_parallel.c:925:   if (neighbours[EAST] != MPI_PROC_NULL)
	cmp	DWORD PTR 8[r13], -2	# MEM[(const int *)neighbours_42(D) + 8B],
	jne	.L281	#,
.L271:
# stencil_template_parallel.c:945:   if (neighbours[WEST] != MPI_PROC_NULL)
	cmp	DWORD PTR 12[r13], -2	# MEM[(const int *)neighbours_42(D) + 12B],
	jne	.L273	#,
.L275:
# stencil_template_parallel.c:963:   return 0;
	xor	eax, eax	# <retval>
.L265:
# stencil_template_parallel.c:964: }
	pop	rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp	#
	.cfi_def_cfa_offset 32
	pop	r12	#
	.cfi_def_cfa_offset 24
	pop	r13	#
	.cfi_def_cfa_offset 16
	pop	r14	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L281:
	.cfi_restore_state
# stencil_template_parallel.c:927:     buffers_ptr[SEND][EAST] = (double *)malloc(ysize * sizeof(double));
	mov	ebp, r14d	# _5, _5
	sal	rbp, 3	# _15,
	mov	rdi, rbp	#, _15
	call	malloc@PLT	#
# stencil_template_parallel.c:927:     buffers_ptr[SEND][EAST] = (double *)malloc(ysize * sizeof(double));
	mov	QWORD PTR 16[r12], rax	# (*buffers_ptr_35(D))[2], tmp134
# stencil_template_parallel.c:928:     if (buffers_ptr[SEND][EAST] == NULL)
	test	rax, rax	# tmp134
	je	.L282	#,
# stencil_template_parallel.c:935:     buffers_ptr[RECV][EAST] = (double *)malloc(ysize * sizeof(double));
	mov	rdi, rbp	#, _15
	call	malloc@PLT	#
# stencil_template_parallel.c:935:     buffers_ptr[RECV][EAST] = (double *)malloc(ysize * sizeof(double));
	mov	QWORD PTR 48[r12], rax	# MEM[(double * restrict[4] *)buffers_ptr_35(D) + 32B][2], tmp138
# stencil_template_parallel.c:936:     if (buffers_ptr[RECV][EAST] == NULL)
	test	rax, rax	# tmp138
	jne	.L271	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 44	#,
	mov	esi, 1	#,
	lea	rdi, .LC11[rip]	# tmp140,
	call	fwrite@PLT	#
# stencil_template_parallel.c:939:       free(buffers_ptr[RECV][EAST]);
	mov	rdi, QWORD PTR 48[r12]	# MEM[(double * restrict[4] *)buffers_ptr_35(D) + 32B][2], MEM[(double * restrict[4] *)buffers_ptr_35(D) + 32B][2]
	call	free@PLT	#
# stencil_template_parallel.c:940:       return 1;
	mov	eax, 1	# <retval>,
	jmp	.L265	#
	.p2align 4,,10
	.p2align 3
.L273:
# stencil_template_parallel.c:947:     buffers_ptr[SEND][WEST] = (double *)malloc(ysize * sizeof(double));
	sal	r14, 3	# _24,
	mov	rdi, r14	#, _24
	call	malloc@PLT	#
# stencil_template_parallel.c:947:     buffers_ptr[SEND][WEST] = (double *)malloc(ysize * sizeof(double));
	mov	QWORD PTR 24[r12], rax	# (*buffers_ptr_35(D))[3], tmp143
# stencil_template_parallel.c:948:     if (buffers_ptr[SEND][WEST] == NULL)
	test	rax, rax	# tmp143
	je	.L283	#,
# stencil_template_parallel.c:955:     buffers_ptr[RECV][WEST] = (double *)malloc(ysize * sizeof(double));
	mov	rdi, r14	#, _24
	call	malloc@PLT	#
# stencil_template_parallel.c:955:     buffers_ptr[RECV][WEST] = (double *)malloc(ysize * sizeof(double));
	mov	QWORD PTR 56[r12], rax	# MEM[(double * restrict[4] *)buffers_ptr_35(D) + 32B][3], tmp147
# stencil_template_parallel.c:956:     if (buffers_ptr[RECV][WEST] == NULL)
	test	rax, rax	# tmp147
	jne	.L275	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 44	#,
	mov	esi, 1	#,
	lea	rdi, .LC13[rip]	# tmp149,
	call	fwrite@PLT	#
# stencil_template_parallel.c:959:       free(buffers_ptr[RECV][WEST]);
	mov	rdi, QWORD PTR 56[r12]	# MEM[(double * restrict[4] *)buffers_ptr_35(D) + 32B][3], MEM[(double * restrict[4] *)buffers_ptr_35(D) + 32B][3]
	call	free@PLT	#
# stencil_template_parallel.c:960:       return 1;
	mov	eax, 1	# <retval>,
	jmp	.L265	#
	.p2align 4,,10
	.p2align 3
.L278:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 29	#,
	mov	esi, 1	#,
	lea	rdi, .LC7[rip]	# tmp121,
	call	fwrite@PLT	#
# stencil_template_parallel.c:964: }
	pop	rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp	#
	.cfi_def_cfa_offset 32
	pop	r12	#
	.cfi_def_cfa_offset 24
	pop	r13	#
	.cfi_def_cfa_offset 16
# stencil_template_parallel.c:875:     return 1;
	mov	eax, 1	# <retval>,
# stencil_template_parallel.c:964: }
	pop	r14	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L277:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 28	#,
	mov	esi, 1	#,
	lea	rdi, .LC6[rip]	# tmp119,
	call	fwrite@PLT	#
# stencil_template_parallel.c:867:     return 1;
	mov	eax, 1	# <retval>,
	jmp	.L265	#
.L280:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 48	#,
	mov	esi, 1	#,
	lea	rdi, .LC9[rip]	# tmp132,
	call	fwrite@PLT	#
# stencil_template_parallel.c:898:     return 1;
	mov	eax, 1	# <retval>,
	jmp	.L265	#
.L279:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 48	#,
	mov	esi, 1	#,
	lea	rdi, .LC8[rip]	# tmp129,
	call	fwrite@PLT	#
# stencil_template_parallel.c:889:     return 1;
	mov	eax, 1	# <retval>,
	jmp	.L265	#
.L282:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 44	#,
	mov	esi, 1	#,
	lea	rdi, .LC10[rip]	# tmp136,
	call	fwrite@PLT	#
# stencil_template_parallel.c:931:       free(buffers_ptr[SEND][EAST]);
	mov	rdi, QWORD PTR 16[r12]	# (*buffers_ptr_35(D))[2], (*buffers_ptr_35(D))[2]
	call	free@PLT	#
# stencil_template_parallel.c:932:       return 1;
	mov	eax, 1	# <retval>,
	jmp	.L265	#
.L283:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 44	#,
	mov	esi, 1	#,
	lea	rdi, .LC12[rip]	# tmp145,
	call	fwrite@PLT	#
# stencil_template_parallel.c:951:       free(buffers_ptr[SEND][WEST]);
	mov	rdi, QWORD PTR 24[r12]	# (*buffers_ptr_35(D))[3], (*buffers_ptr_35(D))[3]
	call	free@PLT	#
# stencil_template_parallel.c:952:       return 1;
	mov	eax, 1	# <retval>,
	jmp	.L265	#
	.cfi_endproc
.LFE76:
	.size	memory_allocate, .-memory_allocate
	.section	.rodata.str1.8
	.align 8
.LC15:
	.string	"task %d :: error - planes is NULL\n"
	.align 8
.LC17:
	.ascii	"\nvalid options are ( values btw [] are the default values"
	.string	" ):\n-x    x size of the plate [10000]\n-y    y size of the plate [10000]\n-e    how many energy sources on the plate [4]\n-E    how many energy sources on the plate [1.0]\n-n    how many iterations [1000]\n-p    whether periodic boundaries applies  [0 = false]\n"
	.align 8
.LC18:
	.string	"option -%c requires an argument\n"
	.align 8
.LC19:
	.string	" -------- help unavailable ----------"
	.section	.rodata.str1.1
.LC20:
	.string	":hx:y:e:E:n:o:p:v:"
.LC21:
	.string	"Grid must be positive\n"
	.section	.rodata.str1.8
	.align 8
.LC22:
	.string	"Number of sources must be non-negative and smaller than the grid size\n"
	.align 8
.LC23:
	.string	"Energy per source must be non-negative\n"
	.align 8
.LC24:
	.string	"Number of iterations must be positive\n"
	.align 8
.LC25:
	.string	"Tasks are decomposed in a grid %d x %d\n\n"
	.align 8
.LC26:
	.string	"Task %4d :: \tgrid coordinates : %3d, %3d\n\tneighbours: N %4d    E %4d    S %4d    W %4d\n"
	.text
	.p2align 4
	.globl	initialize
	.type	initialize, @function
initialize:
.LFB73:
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	push	r15	#
	push	r14	#
	push	r13	#
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	mov	r13, r8	# argv, tmp410
	push	r12	#
	.cfi_offset 12, -48
	mov	r12d, ecx	# argc, tmp409
	push	r10	#
	.cfi_offset 10, -56
	lea	r10, 16[rbp]	#,
	push	rbx	#
	add	rsp, -128	#,
	.cfi_offset 3, -64
# stencil_template_parallel.c:441: {
	mov	rax, QWORD PTR [r10]	# N, N
	mov	rcx, QWORD PTR 8[r10]	# periodic, periodic
	mov	QWORD PTR -160[rbp], rax	# %sfp, N
	mov	rax, QWORD PTR 16[r10]	# output_energy_stat, output_energy_stat
	mov	rbx, QWORD PTR 32[r10]	# Niterations, Niterations
	mov	QWORD PTR -112[rbp], rax	# %sfp, output_energy_stat
	mov	rax, QWORD PTR 24[r10]	# neighbours, neighbours
	mov	r11, QWORD PTR 64[r10]	# energy_per_source, energy_per_source
	mov	QWORD PTR -152[rbp], rdi	# %sfp, tmp406
	mov	DWORD PTR -72[rbp], esi	# %sfp, tmp407
	mov	rdi, QWORD PTR 56[r10]	# Sources_local, Sources_local
	mov	rsi, QWORD PTR 40[r10]	# Nsources, Nsources
	mov	DWORD PTR -120[rbp], edx	# %sfp, tmp408
	mov	QWORD PTR -128[rbp], rax	# %sfp, neighbours
	mov	rdx, QWORD PTR 48[r10]	# Nsources_local, Nsources_local
	mov	r8, QWORD PTR 72[r10]	# planes, planes
	mov	rax, QWORD PTR 80[r10]	# buffers, buffers
	mov	QWORD PTR -88[rbp], rcx	# %sfp, periodic
	mov	QWORD PTR -96[rbp], rbx	# %sfp, Niterations
	mov	QWORD PTR -80[rbp], rsi	# %sfp, Nsources
	mov	QWORD PTR -168[rbp], rdx	# %sfp, Nsources_local
	mov	QWORD PTR -176[rbp], rdi	# %sfp, Sources_local
	mov	QWORD PTR -104[rbp], r11	# %sfp, energy_per_source
	mov	QWORD PTR -136[rbp], r8	# %sfp, planes
	mov	QWORD PTR -144[rbp], rax	# %sfp, buffers
# stencil_template_parallel.c:449:   (*S)[_x_] = 10000;
	mov	rax, QWORD PTR fs:40	# tmp432, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR -56[rbp], rax	# D.14347, tmp432
	movabs	rax, 42949672970000	# tmp432,
	mov	QWORD PTR [r9], rax	# MEM <unsigned long> [(unsigned int *)S_166(D)], tmp500
# stencil_template_parallel.c:456:   *energy_per_source = 1.0;
	mov	rax, QWORD PTR .LC14[rip]	# tmp507,
# stencil_template_parallel.c:451:   *periodic = 0;
	mov	DWORD PTR [rcx], 0	# *periodic_169(D),
# stencil_template_parallel.c:452:   *Nsources = 4;
	mov	DWORD PTR [rsi], 4	# *Nsources_171(D),
# stencil_template_parallel.c:453:   *Nsources_local = 0;
	mov	DWORD PTR [rdx], 0	# *Nsources_local_173(D),
# stencil_template_parallel.c:454:   *Sources_local = NULL;
	mov	QWORD PTR [rdi], 0	# *Sources_local_175(D),
# stencil_template_parallel.c:455:   *Niterations = 1000;
	mov	DWORD PTR [rbx], 1000	# *Niterations_177(D),
# stencil_template_parallel.c:456:   *energy_per_source = 1.0;
	mov	QWORD PTR [r11], rax	# *energy_per_source_179(D), tmp507
# stencil_template_parallel.c:458:   if (planes == NULL)
	test	r8, r8	# planes
	je	.L385	#,
# stencil_template_parallel.c:472:     neighbours[i] = MPI_PROC_NULL;
	vpbroadcastd	xmm0, DWORD PTR .LC27[rip]	# tmp254,
	mov	rax, QWORD PTR -128[rbp]	# neighbours, %sfp
# stencil_template_parallel.c:468:   planes[OLD].size[0] = planes[OLD].size[1] = 0;
	mov	QWORD PTR 8[r8], 0	# MEM <unsigned long> [(unsigned int *)planes_181(D) + 8B],
# stencil_template_parallel.c:469:   planes[NEW].size[0] = planes[NEW].size[1] = 0;
	mov	QWORD PTR 24[r8], 0	# MEM <unsigned long> [(unsigned int *)planes_181(D) + 24B],
# stencil_template_parallel.c:472:     neighbours[i] = MPI_PROC_NULL;
	vmovdqu	XMMWORD PTR [rax], xmm0	# MEM <vector(4) int> [(int *)neighbours_206(D)], tmp254
# stencil_template_parallel.c:476:       buffers[b][d] = NULL;
	mov	rax, QWORD PTR -144[rbp]	# buffers, %sfp
	vpxor	xmm0, xmm0, xmm0	# tmp255
	mov	r15, r9	# S, tmp411
	lea	r14, .LC20[rip]	# tmp378,
# stencil_template_parallel.c:486:       switch (opt)
	lea	rbx, .L290[rip]	# tmp401,
# stencil_template_parallel.c:444:   int verbose = 0;
	mov	DWORD PTR -116[rbp], 0	# %sfp,
# stencil_template_parallel.c:442:   int halt = 0;
	mov	DWORD PTR -68[rbp], 0	# %sfp,
# stencil_template_parallel.c:476:       buffers[b][d] = NULL;
	vmovdqu	YMMWORD PTR [rax], ymm0	# MEM <vector(4) long unsigned int> [(double * *)buffers_236(D)], tmp255
	vmovdqu	YMMWORD PTR 32[rax], ymm0	# MEM <vector(4) long unsigned int> [(double * *)buffers_236(D) + 32B], tmp255
	vzeroupper
	.p2align 4,,10
	.p2align 3
.L370:
# stencil_template_parallel.c:484:     while ((opt = getopt(argc, argv, ":hx:y:e:E:n:o:p:v:")) != -1)
	mov	rdx, r14	#, tmp378
	mov	rsi, r13	#, argv
	mov	edi, r12d	#, argc
	call	getopt@PLT	#
# stencil_template_parallel.c:484:     while ((opt = getopt(argc, argv, ":hx:y:e:E:n:o:p:v:")) != -1)
	cmp	eax, -1	# opt,
	je	.L386	#,
# stencil_template_parallel.c:486:       switch (opt)
	sub	eax, 58	#,
	cmp	eax, 63	# tmp257,
	ja	.L370	#,
	movsx	rax, DWORD PTR [rbx+rax*4]	# tmp261,
	add	rax, rbx	# tmp262, tmp401
	notrack jmp	rax	# tmp262
	.section	.rodata
	.align 4
	.align 4
.L290:
	.long	.L300-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L299-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L298-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L297-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L296-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L295-.L290
	.long	.L294-.L290
	.long	.L293-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L370-.L290
	.long	.L292-.L290
	.long	.L370-.L290
	.long	.L291-.L290
	.long	.L289-.L290
	.text
	.p2align 4,,10
	.p2align 3
.L289:
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	mov	rdi, QWORD PTR optarg[rip]	#, optarg
	mov	edx, 10	#,
	xor	esi, esi	#
	call	strtol@PLT	#
# stencil_template_parallel.c:493:         (*S)[_y_] = (uint)atoi(optarg);
	mov	DWORD PTR 4[r15], eax	# (*S_166(D))[1], tmp413
# stencil_template_parallel.c:494:         break;
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L291:
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	mov	rdi, QWORD PTR optarg[rip]	#, optarg
	mov	edx, 10	#,
	xor	esi, esi	#
	call	strtol@PLT	#
# stencil_template_parallel.c:489:         (*S)[_x_] = (uint)atoi(optarg);
	mov	DWORD PTR [r15], eax	# (*S_166(D))[0], tmp412
# stencil_template_parallel.c:490:         break;
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L292:
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	mov	rdi, QWORD PTR optarg[rip]	#, optarg
	mov	edx, 10	#,
	xor	esi, esi	#
	call	strtol@PLT	#
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	mov	DWORD PTR -116[rbp], eax	# %sfp, tmp419
# stencil_template_parallel.c:518:         break;
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L293:
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	mov	rdi, QWORD PTR optarg[rip]	#, optarg
	xor	esi, esi	#
	mov	edx, 10	#,
	call	strtol@PLT	#
# stencil_template_parallel.c:513:         *periodic = (atoi(optarg) > 0);
	test	eax, eax	# tmp418
# stencil_template_parallel.c:513:         *periodic = (atoi(optarg) > 0);
	mov	rcx, QWORD PTR -88[rbp]	# periodic, %sfp
# stencil_template_parallel.c:513:         *periodic = (atoi(optarg) > 0);
	setg	al	#, tmp273
	movzx	eax, al	# tmp273, tmp273
# stencil_template_parallel.c:513:         *periodic = (atoi(optarg) > 0);
	mov	DWORD PTR [rcx], eax	#* periodic, tmp273
# stencil_template_parallel.c:514:         break;
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L294:
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	mov	rdi, QWORD PTR optarg[rip]	#, optarg
	xor	esi, esi	#
	mov	edx, 10	#,
	call	strtol@PLT	#
# stencil_template_parallel.c:509:         *output_energy_stat = (atoi(optarg) > 0);
	test	eax, eax	# tmp417
# stencil_template_parallel.c:509:         *output_energy_stat = (atoi(optarg) > 0);
	mov	rcx, QWORD PTR -112[rbp]	# output_energy_stat, %sfp
# stencil_template_parallel.c:509:         *output_energy_stat = (atoi(optarg) > 0);
	setg	al	#, tmp270
	movzx	eax, al	# tmp270, tmp270
# stencil_template_parallel.c:509:         *output_energy_stat = (atoi(optarg) > 0);
	mov	DWORD PTR [rcx], eax	#* output_energy_stat, tmp270
# stencil_template_parallel.c:510:         break;
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L295:
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	mov	rdi, QWORD PTR optarg[rip]	#, optarg
	mov	edx, 10	#,
	xor	esi, esi	#
	call	strtol@PLT	#
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	mov	rcx, QWORD PTR -96[rbp]	# Niterations, %sfp
	mov	DWORD PTR [rcx], eax	#* Niterations, tmp416
# stencil_template_parallel.c:506:         break;
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L296:
# stencil_template_parallel.c:522:         if (Me == 0)
	mov	eax, DWORD PTR -72[rbp]	#, %sfp
# stencil_template_parallel.c:530:         halt = 1;
	mov	DWORD PTR -68[rbp], 1	# %sfp,
# stencil_template_parallel.c:522:         if (Me == 0)
	test	eax, eax	#
	jne	.L370	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	lea	rdi, .LC17[rip]	#,
	call	puts@PLT	#
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L297:
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	mov	rdi, QWORD PTR optarg[rip]	#, optarg
	mov	edx, 10	#,
	xor	esi, esi	#
	call	strtol@PLT	#
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	mov	rcx, QWORD PTR -80[rbp]	# Nsources, %sfp
	mov	DWORD PTR [rcx], eax	#* Nsources, tmp414
# stencil_template_parallel.c:498:         break;
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L298:
# /usr/include/x86_64-linux-gnu/bits/stdlib-float.h:27:   return strtod (__nptr, (char **) NULL);
	mov	rdi, QWORD PTR optarg[rip]	#, optarg
	xor	esi, esi	#
	call	strtod@PLT	#
# stencil_template_parallel.c:501:         *energy_per_source = atof(optarg);
	mov	rax, QWORD PTR -104[rbp]	# energy_per_source, %sfp
	vmovsd	QWORD PTR [rax], xmm0	# *energy_per_source_179(D), tmp415
# stencil_template_parallel.c:502:         break;
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L299:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	lea	rdi, .LC19[rip]	#,
	call	puts@PLT	#
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L300:
	mov	edx, DWORD PTR optopt[rip]	#, optopt
	lea	rsi, .LC18[rip]	#,
	mov	edi, 1	#,
	xor	eax, eax	#
	call	__printf_chk@PLT	#
	jmp	.L370	#
	.p2align 4,,10
	.p2align 3
.L386:
# stencil_template_parallel.c:548:   if (halt)
	mov	eax, DWORD PTR -68[rbp]	#, %sfp
	test	eax, eax	#
	jne	.L284	#,
# stencil_template_parallel.c:556:   if (((*S)[_x_] < 1) || ((*S)[_y_] < 1))
	mov	r13d, DWORD PTR [r15]	# _26, (*S_166(D))[0]
# stencil_template_parallel.c:556:   if (((*S)[_x_] < 1) || ((*S)[_y_] < 1))
	test	r13d, r13d	# _26
	je	.L303	#,
# stencil_template_parallel.c:556:   if (((*S)[_x_] < 1) || ((*S)[_y_] < 1))
	mov	r14d, DWORD PTR 4[r15]	# _27, (*S_166(D))[1]
# stencil_template_parallel.c:556:   if (((*S)[_x_] < 1) || ((*S)[_y_] < 1))
	test	r14d, r14d	# _27
	je	.L303	#,
# stencil_template_parallel.c:563:   if (*Nsources < 0 || *Nsources > (int)((*S)[_x_] * (*S)[_y_]))
	mov	rax, QWORD PTR -80[rbp]	# Nsources, %sfp
	mov	eax, DWORD PTR [rax]	# _29, *Nsources_171(D)
# stencil_template_parallel.c:563:   if (*Nsources < 0 || *Nsources > (int)((*S)[_x_] * (*S)[_y_]))
	test	eax, eax	# _29
	js	.L305	#,
# stencil_template_parallel.c:563:   if (*Nsources < 0 || *Nsources > (int)((*S)[_x_] * (*S)[_y_]))
	mov	edx, r13d	# tmp283, _26
	imul	edx, r14d	# tmp283, _27
# stencil_template_parallel.c:563:   if (*Nsources < 0 || *Nsources > (int)((*S)[_x_] * (*S)[_y_]))
	cmp	eax, edx	# _29, tmp283
	jg	.L305	#,
# stencil_template_parallel.c:570:   if (*energy_per_source < 0.0)
	mov	rax, QWORD PTR -104[rbp]	# energy_per_source, %sfp
	vxorpd	xmm0, xmm0, xmm0	# tmp286
	vcomisd	xmm0, QWORD PTR [rax]	# tmp286, *energy_per_source_179(D)
	ja	.L387	#,
# stencil_template_parallel.c:576:   if (*Niterations <= 0)
	mov	rax, QWORD PTR -96[rbp]	# Niterations, %sfp
	mov	ebx, DWORD PTR [rax]	#, *Niterations_177(D)
	test	ebx, ebx	#
	jle	.L388	#,
	vxorps	xmm2, xmm2, xmm2	# tmp422
# stencil_template_parallel.c:596:   double formfactor = ((*S)[_x_] >= (*S)[_y_] ? (double)(*S)[_x_] / (*S)[_y_] : (double)(*S)[_y_] / (*S)[_x_]);
	vcvtusi2sd	xmm0, xmm2, r14d	# tmp423, tmp422, _27
# stencil_template_parallel.c:596:   double formfactor = ((*S)[_x_] >= (*S)[_y_] ? (double)(*S)[_x_] / (*S)[_y_] : (double)(*S)[_y_] / (*S)[_x_]);
	vcvtusi2sd	xmm1, xmm2, r13d	# tmp424, tmp422, _26
# stencil_template_parallel.c:596:   double formfactor = ((*S)[_x_] >= (*S)[_y_] ? (double)(*S)[_x_] / (*S)[_y_] : (double)(*S)[_y_] / (*S)[_x_]);
	cmp	r13d, r14d	# _26, _27
	jnb	.L389	#,
# stencil_template_parallel.c:596:   double formfactor = ((*S)[_x_] >= (*S)[_y_] ? (double)(*S)[_x_] / (*S)[_y_] : (double)(*S)[_y_] / (*S)[_x_]);
	vdivsd	xmm0, xmm0, xmm1	# iftmp.100_51, _408, _409
# stencil_template_parallel.c:597:   int dimensions = 2 - (Ntasks <= ((int)formfactor + 1));
	vcvttsd2si	eax, xmm0	# tmp293, iftmp.100_51
# stencil_template_parallel.c:597:   int dimensions = 2 - (Ntasks <= ((int)formfactor + 1));
	inc	eax	# tmp294
# stencil_template_parallel.c:597:   int dimensions = 2 - (Ntasks <= ((int)formfactor + 1));
	cmp	DWORD PTR -120[rbp], eax	# %sfp, tmp294
	jg	.L312	#,
.L383:
# stencil_template_parallel.c:622:   (*N)[_x_] = Grid[_x_];
	mov	rax, QWORD PTR -160[rbp]	# N, %sfp
# stencil_template_parallel.c:623:   (*N)[_y_] = Grid[_y_];
	mov	ecx, DWORD PTR -120[rbp]	# Ntasks, %sfp
# stencil_template_parallel.c:629:   int Y = Me / Grid[_x_];
	mov	esi, DWORD PTR -72[rbp]	# Me, %sfp
# stencil_template_parallel.c:622:   (*N)[_x_] = Grid[_x_];
	mov	DWORD PTR [rax], 1	# (*N_199(D))[0],
# stencil_template_parallel.c:623:   (*N)[_y_] = Grid[_y_];
	mov	DWORD PTR 4[rax], ecx	# (*N_199(D))[1], Ntasks
# stencil_template_parallel.c:629:   int Y = Me / Grid[_x_];
	mov	ebx, esi	# Y, Me
# stencil_template_parallel.c:628:   int X = Me % Grid[_x_];
	xor	r12d, r12d	# X
# stencil_template_parallel.c:623:   (*N)[_y_] = Grid[_y_];
	mov	r9d, 1	# Grid$0,
# stencil_template_parallel.c:628:   int X = Me % Grid[_x_];
	xor	edi, edi	# _58
.L326:
# stencil_template_parallel.c:650:   if (Grid[_y_] > 1)
	cmp	ecx, 1	# Grid$1,
	jbe	.L334	#,
# stencil_template_parallel.c:652:     if (*periodic)
	mov	rax, QWORD PTR -88[rbp]	# periodic, %sfp
	mov	r8d, DWORD PTR [rax]	#, *periodic_169(D)
	test	r8d, r8d	#
	je	.L335	#,
# stencil_template_parallel.c:654:       neighbours[NORTH] = (Ntasks + Me - Grid[_x_]) % Ntasks;
	mov	edx, DWORD PTR -120[rbp]	# Ntasks, %sfp
	mov	r11d, DWORD PTR -72[rbp]	# _97, %sfp
	add	r11d, edx	# _97, Ntasks
# stencil_template_parallel.c:654:       neighbours[NORTH] = (Ntasks + Me - Grid[_x_]) % Ntasks;
	mov	eax, r11d	# tmp346, _97
# stencil_template_parallel.c:654:       neighbours[NORTH] = (Ntasks + Me - Grid[_x_]) % Ntasks;
	mov	r8d, r11d	# _97, _97
# stencil_template_parallel.c:654:       neighbours[NORTH] = (Ntasks + Me - Grid[_x_]) % Ntasks;
	sub	eax, r9d	# tmp346, Grid$0
# stencil_template_parallel.c:654:       neighbours[NORTH] = (Ntasks + Me - Grid[_x_]) % Ntasks;
	mov	r11d, edx	# Ntasks, Ntasks
	xor	edx, edx	# tmp348
	div	r11d	# Ntasks
# stencil_template_parallel.c:655:       neighbours[SOUTH] = (Ntasks + Me + Grid[_x_]) % Ntasks;
	lea	eax, [r8+r9]	# tmp350,
# stencil_template_parallel.c:654:       neighbours[NORTH] = (Ntasks + Me - Grid[_x_]) % Ntasks;
	vmovd	xmm0, edx	# tmp348, tmp348
# stencil_template_parallel.c:655:       neighbours[SOUTH] = (Ntasks + Me + Grid[_x_]) % Ntasks;
	xor	edx, edx	# tmp352
	div	r11d	# Ntasks
# stencil_template_parallel.c:654:       neighbours[NORTH] = (Ntasks + Me - Grid[_x_]) % Ntasks;
	mov	rax, QWORD PTR -128[rbp]	# neighbours, %sfp
# stencil_template_parallel.c:654:       neighbours[NORTH] = (Ntasks + Me - Grid[_x_]) % Ntasks;
	vpinsrd	xmm0, xmm0, edx, 1	# vect__101.520, tmp348, tmp352
# stencil_template_parallel.c:654:       neighbours[NORTH] = (Ntasks + Me - Grid[_x_]) % Ntasks;
	vmovq	QWORD PTR [rax], xmm0	# MEM <vector(2) int> [(int *)neighbours_206(D)], vect__101.520
.L334:
	mov	eax, DWORD PTR [r15]	# (*S_166(D))[0], (*S_166(D))[0]
	xor	edx, edx	# tmp356
	div	r9d	# Grid$0
# stencil_template_parallel.c:679:   mysize[_x_] = s + (X < r);
	cmp	edx, edi	# tmp356, _58
	seta	dil	#, tmp358
	movzx	edi, dil	# tmp358, tmp358
# stencil_template_parallel.c:679:   mysize[_x_] = s + (X < r);
	add	edi, eax	# _113, tmp355
	mov	eax, DWORD PTR 4[r15]	# (*S_166(D))[1], (*S_166(D))[1]
	xor	edx, edx	# tmp361
	div	ecx	# Grid$1
# stencil_template_parallel.c:679:   mysize[_x_] = s + (X < r);
	mov	DWORD PTR -64[rbp], edi	# mysize[0], _113
# stencil_template_parallel.c:682:   mysize[_y_] = s + (Y < r);
	cmp	edx, esi	# tmp361, _59
# stencil_template_parallel.c:684:   planes[OLD].size[0] = mysize[0];
	mov	rsi, QWORD PTR -136[rbp]	# planes, %sfp
# stencil_template_parallel.c:682:   mysize[_y_] = s + (Y < r);
	seta	dl	#, tmp363
# stencil_template_parallel.c:684:   planes[OLD].size[0] = mysize[0];
	mov	DWORD PTR 8[rsi], edi	# planes_181(D)->size[0], _113
# stencil_template_parallel.c:686:   planes[NEW].size[0] = mysize[0];
	mov	DWORD PTR 24[rsi], edi	# MEM[(struct plane_t *)planes_181(D) + 16B].size[0], _113
# stencil_template_parallel.c:682:   mysize[_y_] = s + (Y < r);
	movzx	edx, dl	# tmp363, tmp363
# stencil_template_parallel.c:689:   if (verbose > 0)
	mov	edi, DWORD PTR -116[rbp]	#, %sfp
# stencil_template_parallel.c:682:   mysize[_y_] = s + (Y < r);
	add	eax, edx	# _117, tmp363
# stencil_template_parallel.c:682:   mysize[_y_] = s + (Y < r);
	mov	DWORD PTR -60[rbp], eax	# mysize[1], _117
# stencil_template_parallel.c:685:   planes[OLD].size[1] = mysize[1];
	mov	DWORD PTR 12[rsi], eax	# planes_181(D)->size[1], _117
# stencil_template_parallel.c:687:   planes[NEW].size[1] = mysize[1];
	mov	DWORD PTR 28[rsi], eax	# MEM[(struct plane_t *)planes_181(D) + 16B].size[1], _117
# stencil_template_parallel.c:689:   if (verbose > 0)
	test	edi, edi	#
	jle	.L340	#,
# stencil_template_parallel.c:691:     if (Me == 0)
	mov	edx, DWORD PTR -72[rbp]	#, %sfp
	test	edx, edx	#
	je	.L390	#,
.L339:
# stencil_template_parallel.c:698:     MPI_Barrier(*Comm);
	mov	rax, QWORD PTR -152[rbp]	# Comm, %sfp
	mov	rdi, QWORD PTR [rax]	#, *Comm_231(D)
	call	MPI_Barrier@PLT	#
# stencil_template_parallel.c:700:     for (int t = 0; t < Ntasks; t++)
	mov	eax, DWORD PTR -120[rbp]	#, %sfp
	test	eax, eax	#
	jle	.L340	#,
# stencil_template_parallel.c:700:     for (int t = 0; t < Ntasks; t++)
	xor	r14d, r14d	# t
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	lea	r13, .LC26[rip]	# tmp400,
	jmp	.L343	#
.L341:
# stencil_template_parallel.c:713:       MPI_Barrier(*Comm);
	mov	rax, QWORD PTR -152[rbp]	# Comm, %sfp
# stencil_template_parallel.c:700:     for (int t = 0; t < Ntasks; t++)
	inc	r14d	# t
# stencil_template_parallel.c:713:       MPI_Barrier(*Comm);
	mov	rdi, QWORD PTR [rax]	#, *Comm_231(D)
	call	MPI_Barrier@PLT	#
# stencil_template_parallel.c:700:     for (int t = 0; t < Ntasks; t++)
	cmp	DWORD PTR -120[rbp], r14d	# %sfp, t
	je	.L340	#,
.L343:
# stencil_template_parallel.c:702:       if (t == Me)
	cmp	r14d, DWORD PTR -72[rbp]	# t, %sfp
	jne	.L341	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	mov	rcx, QWORD PTR -128[rbp]	# neighbours, %sfp
	sub	rsp, 8	#,
	mov	eax, DWORD PTR 12[rcx]	# MEM[(int *)neighbours_206(D) + 12B], MEM[(int *)neighbours_206(D) + 12B]
	mov	r8d, ebx	#, Y
	push	rax	# MEM[(int *)neighbours_206(D) + 12B]
	mov	edx, r14d	#, t
	mov	rsi, r13	#, tmp400
	mov	eax, DWORD PTR 4[rcx]	# MEM[(int *)neighbours_206(D) + 4B], MEM[(int *)neighbours_206(D) + 4B]
	mov	edi, 1	#,
	push	rax	# MEM[(int *)neighbours_206(D) + 4B]
	mov	eax, DWORD PTR 8[rcx]	# MEM[(int *)neighbours_206(D) + 8B], MEM[(int *)neighbours_206(D) + 8B]
	push	rax	# MEM[(int *)neighbours_206(D) + 8B]
	xor	eax, eax	#
	mov	r9d, DWORD PTR [rcx]	#, *neighbours_206(D)
	mov	ecx, r12d	#, X
	call	__printf_chk@PLT	#
# stencil_template_parallel.c:710:         fflush(stdout);
	mov	rdi, QWORD PTR stdout[rip]	#, stdout
	add	rsp, 32	#,
	call	fflush@PLT	#
	jmp	.L341	#
.L303:
# stencil_template_parallel.c:558:     if (Me == 0)
	mov	r14d, DWORD PTR -72[rbp]	#, %sfp
# stencil_template_parallel.c:549:     return 1;
	mov	DWORD PTR -68[rbp], 1	# %sfp,
# stencil_template_parallel.c:558:     if (Me == 0)
	test	r14d, r14d	#
	je	.L391	#,
.L284:
# stencil_template_parallel.c:728: }
	mov	rax, QWORD PTR -56[rbp]	# tmp433, D.14347
	sub	rax, QWORD PTR fs:40	# tmp433, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L392	#,
	mov	eax, DWORD PTR -68[rbp]	#, %sfp
	lea	rsp, -48[rbp]	#,
	pop	rbx	#
	pop	r10	#
	pop	r12	#
	pop	r13	#
	pop	r14	#
	pop	r15	#
	pop	rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
.L391:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 22	#,
	mov	esi, 1	#,
	lea	rdi, .LC21[rip]	# tmp282,
	call	fwrite@PLT	#
	jmp	.L284	#
.L305:
# stencil_template_parallel.c:565:     if (Me == 0)
	mov	r13d, DWORD PTR -72[rbp]	#, %sfp
# stencil_template_parallel.c:549:     return 1;
	mov	DWORD PTR -68[rbp], 1	# %sfp,
# stencil_template_parallel.c:565:     if (Me == 0)
	test	r13d, r13d	#
	jne	.L284	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 70	#,
	mov	esi, 1	#,
	lea	rdi, .LC22[rip]	# tmp285,
	call	fwrite@PLT	#
	jmp	.L284	#
.L385:
	mov	ecx, DWORD PTR -72[rbp]	#, %sfp
	mov	rdi, QWORD PTR stderr[rip]	#, stderr
	lea	rdx, .LC15[rip]	# tmp253,
	mov	esi, 1	#,
	xor	eax, eax	#
	call	__fprintf_chk@PLT	#
# stencil_template_parallel.c:462:     return 1;
	mov	DWORD PTR -68[rbp], 1	# %sfp,
	jmp	.L284	#
.L389:
# stencil_template_parallel.c:596:   double formfactor = ((*S)[_x_] >= (*S)[_y_] ? (double)(*S)[_x_] / (*S)[_y_] : (double)(*S)[_y_] / (*S)[_x_]);
	vdivsd	xmm0, xmm1, xmm0	# iftmp.100_51, _409, _408
# stencil_template_parallel.c:602:       Grid[_x_] = Ntasks, Grid[_y_] = 1;
	mov	ebx, DWORD PTR -120[rbp]	# Ntasks, %sfp
# stencil_template_parallel.c:602:       Grid[_x_] = Ntasks, Grid[_y_] = 1;
	mov	ecx, 1	# Grid$1,
# stencil_template_parallel.c:602:       Grid[_x_] = Ntasks, Grid[_y_] = 1;
	mov	r9d, ebx	# Grid$0, Ntasks
# stencil_template_parallel.c:597:   int dimensions = 2 - (Ntasks <= ((int)formfactor + 1));
	vcvttsd2si	eax, xmm0	# tmp291, iftmp.100_51
# stencil_template_parallel.c:597:   int dimensions = 2 - (Ntasks <= ((int)formfactor + 1));
	inc	eax	# tmp292
# stencil_template_parallel.c:597:   int dimensions = 2 - (Ntasks <= ((int)formfactor + 1));
	cmp	ebx, eax	# Ntasks, tmp292
	jg	.L312	#,
.L311:
# stencil_template_parallel.c:622:   (*N)[_x_] = Grid[_x_];
	mov	rax, QWORD PTR -160[rbp]	# N, %sfp
# stencil_template_parallel.c:628:   int X = Me % Grid[_x_];
	xor	edx, edx	# _58
# stencil_template_parallel.c:622:   (*N)[_x_] = Grid[_x_];
	mov	DWORD PTR [rax], r9d	# (*N_199(D))[0], Grid$0
# stencil_template_parallel.c:623:   (*N)[_y_] = Grid[_y_];
	mov	DWORD PTR 4[rax], ecx	# (*N_199(D))[1], Grid$1
# stencil_template_parallel.c:628:   int X = Me % Grid[_x_];
	mov	eax, DWORD PTR -72[rbp]	# tmp331, %sfp
	div	r9d	# Grid$0
	mov	edi, edx	# _58, _58
# stencil_template_parallel.c:628:   int X = Me % Grid[_x_];
	mov	r12d, edx	# X, _58
# stencil_template_parallel.c:629:   int Y = Me / Grid[_x_];
	mov	esi, eax	# _59, tmp331
# stencil_template_parallel.c:629:   int Y = Me / Grid[_x_];
	mov	ebx, eax	# Y, _59
# stencil_template_parallel.c:635:   if (Grid[_x_] > 1)
	cmp	r9d, 1	# Grid$0,
	jbe	.L326	#,
.L328:
# stencil_template_parallel.c:637:     if (*periodic)
	mov	rax, QWORD PTR -88[rbp]	# periodic, %sfp
	mov	r10d, DWORD PTR [rax]	#, *periodic_169(D)
	test	r10d, r10d	#
	je	.L329	#,
# stencil_template_parallel.c:639:       neighbours[EAST] = Y * Grid[_x_] + (Me + 1) % Grid[_x_];
	mov	r11d, DWORD PTR -72[rbp]	# Me, %sfp
# stencil_template_parallel.c:639:       neighbours[EAST] = Y * Grid[_x_] + (Me + 1) % Grid[_x_];
	xor	edx, edx	# tmp335
# stencil_template_parallel.c:639:       neighbours[EAST] = Y * Grid[_x_] + (Me + 1) % Grid[_x_];
	lea	eax, 1[r11]	# tmp333,
# stencil_template_parallel.c:639:       neighbours[EAST] = Y * Grid[_x_] + (Me + 1) % Grid[_x_];
	div	r9d	# Grid$0
# stencil_template_parallel.c:639:       neighbours[EAST] = Y * Grid[_x_] + (Me + 1) % Grid[_x_];
	mov	eax, esi	# tmp337, _59
	imul	eax, r9d	# tmp337, Grid$0
# stencil_template_parallel.c:639:       neighbours[EAST] = Y * Grid[_x_] + (Me + 1) % Grid[_x_];
	add	edx, eax	# tmp338, tmp337
	mov	rax, QWORD PTR -128[rbp]	# neighbours, %sfp
	mov	DWORD PTR 8[rax], edx	# MEM[(int *)neighbours_206(D) + 8B], tmp338
# stencil_template_parallel.c:640:       neighbours[WEST] = (X % Grid[_x_] > 0 ? Me - 1 : (Y + 1) * Grid[_x_] - 1);
	lea	eax, -1[r11]	# iftmp.113_143,
	test	edi, edi	# _58
	jne	.L331	#,
# stencil_template_parallel.c:640:       neighbours[WEST] = (X % Grid[_x_] > 0 ? Me - 1 : (Y + 1) * Grid[_x_] - 1);
	lea	eax, 1[rbx]	# tmp339,
# stencil_template_parallel.c:640:       neighbours[WEST] = (X % Grid[_x_] > 0 ? Me - 1 : (Y + 1) * Grid[_x_] - 1);
	imul	eax, r9d	# tmp340, Grid$0
# stencil_template_parallel.c:640:       neighbours[WEST] = (X % Grid[_x_] > 0 ? Me - 1 : (Y + 1) * Grid[_x_] - 1);
	dec	eax	# iftmp.113_143
.L331:
# stencil_template_parallel.c:640:       neighbours[WEST] = (X % Grid[_x_] > 0 ? Me - 1 : (Y + 1) * Grid[_x_] - 1);
	mov	rdx, QWORD PTR -128[rbp]	# neighbours, %sfp
	mov	DWORD PTR 12[rdx], eax	# MEM[(int *)neighbours_206(D) + 12B], iftmp.113_143
	jmp	.L326	#
.L340:
# stencil_template_parallel.c:720:   ret = memory_allocate(neighbours, *N, buffers, planes);
	mov	rcx, QWORD PTR -136[rbp]	#, %sfp
	mov	rdx, QWORD PTR -144[rbp]	#, %sfp
	mov	rsi, QWORD PTR -160[rbp]	#, %sfp
	mov	rdi, QWORD PTR -128[rbp]	#, %sfp
	call	memory_allocate	#
# stencil_template_parallel.c:725:   ret = initialize_sources(Me, Ntasks, Comm, mysize, *Nsources, Nsources_local, Sources_local);
	sub	rsp, 8	#,
	mov	rax, QWORD PTR -80[rbp]	# Nsources, %sfp
	push	QWORD PTR -176[rbp]	# %sfp
	mov	esi, DWORD PTR -120[rbp]	#, %sfp
	mov	r9, QWORD PTR -168[rbp]	#, %sfp
	mov	r8d, DWORD PTR [rax]	#, *Nsources_171(D)
	mov	rdx, QWORD PTR -152[rbp]	#, %sfp
	mov	edi, DWORD PTR -72[rbp]	#, %sfp
	lea	rcx, -64[rbp]	# tmp365,
	call	initialize_sources	#
# stencil_template_parallel.c:727:   return 0;
	pop	rcx	#
	pop	rsi	#
	jmp	.L284	#
.L387:
# stencil_template_parallel.c:572:     if (Me == 0)
	mov	r12d, DWORD PTR -72[rbp]	#, %sfp
# stencil_template_parallel.c:549:     return 1;
	mov	DWORD PTR -68[rbp], 1	# %sfp,
# stencil_template_parallel.c:572:     if (Me == 0)
	test	r12d, r12d	#
	jne	.L284	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 39	#,
	mov	esi, 1	#,
	lea	rdi, .LC23[rip]	# tmp288,
	call	fwrite@PLT	#
	jmp	.L284	#
.L312:
# stencil_template_parallel.c:742:   while (f < A)
	mov	eax, DWORD PTR -120[rbp]	# Ntasks, %sfp
# stencil_template_parallel.c:738:   int N = 0;
	xor	r12d, r12d	# N
# stencil_template_parallel.c:742:   while (f < A)
	mov	ecx, eax	# _A_, Ntasks
# stencil_template_parallel.c:739:   int f = 2;
	mov	ebx, 2	# f,
# stencil_template_parallel.c:610:     uint first = 1;
	mov	r9d, 1	# Grid$0,
# stencil_template_parallel.c:742:   while (f < A)
	cmp	eax, 2	# Ntasks,
	jbe	.L315	#,
	mov	esi, eax	# Ntasks, Ntasks
.L314:
# stencil_template_parallel.c:744:     while (_A_ % f == 0)
	mov	eax, ecx	# tmp305, _A_
	xor	edx, edx	# tmp304
	div	ebx	# f
# stencil_template_parallel.c:744:     while (_A_ % f == 0)
	test	edx, edx	# tmp304
	jne	.L318	#,
	.p2align 4,,10
	.p2align 3
.L316:
# stencil_template_parallel.c:747:       _A_ /= f;
	mov	eax, ecx	# _A_, _A_
	xor	edx, edx	# tmp296
	div	ebx	# f
# stencil_template_parallel.c:744:     while (_A_ % f == 0)
	xor	edx, edx	# tmp298
# stencil_template_parallel.c:746:       N++;
	inc	r12d	# N
# stencil_template_parallel.c:747:       _A_ /= f;
	mov	ecx, eax	# _A_, _A_
# stencil_template_parallel.c:744:     while (_A_ % f == 0)
	div	ebx	# f
# stencil_template_parallel.c:744:     while (_A_ % f == 0)
	test	edx, edx	# tmp298
	je	.L316	#,
.L318:
# stencil_template_parallel.c:750:     f++;
	lea	r10d, 1[rbx]	# f,
# stencil_template_parallel.c:742:   while (f < A)
	cmp	esi, r10d	# Ntasks, f
	je	.L317	#,
	mov	ebx, r10d	# f, f
	jmp	.L314	#
.L321:
# stencil_template_parallel.c:613:     for (int i = 0; (i < Nf) && ((Ntasks / first) / first > formfactor); i++)
	test	r12d, r12d	# N
	je	.L324	#,
# stencil_template_parallel.c:613:     for (int i = 0; (i < Nf) && ((Ntasks / first) / first > formfactor); i++)
	vcvtsi2sd	xmm1, xmm2, r10d	# tmp425, tmp422, f
# stencil_template_parallel.c:613:     for (int i = 0; (i < Nf) && ((Ntasks / first) / first > formfactor); i++)
	vcomisd	xmm1, xmm0	# tmp321, iftmp.100_51
	jbe	.L324	#,
	lea	eax, -1[r12]	# tmp323,
	lea	rsi, [r8+rax*4]	# _381,
# stencil_template_parallel.c:610:     uint first = 1;
	mov	r9d, 1	# Grid$0,
	jmp	.L327	#
.L393:
# stencil_template_parallel.c:613:     for (int i = 0; (i < Nf) && ((Ntasks / first) / first > formfactor); i++)
	xor	edx, edx	# tmp329
	div	r9d	# Grid$0
# stencil_template_parallel.c:613:     for (int i = 0; (i < Nf) && ((Ntasks / first) / first > formfactor); i++)
	add	r8, 4	# ivtmp.529,
# stencil_template_parallel.c:613:     for (int i = 0; (i < Nf) && ((Ntasks / first) / first > formfactor); i++)
	vcvtsi2sd	xmm1, xmm2, eax	# tmp426, tmp422, tmp328
# stencil_template_parallel.c:613:     for (int i = 0; (i < Nf) && ((Ntasks / first) / first > formfactor); i++)
	vcomisd	xmm1, xmm0	# tmp330, iftmp.100_51
	jbe	.L315	#,
.L327:
# stencil_template_parallel.c:614:       first *= factors[i];
	imul	r9d, DWORD PTR [r8]	# Grid$0, MEM[(uint *)_372]
# stencil_template_parallel.c:613:     for (int i = 0; (i < Nf) && ((Ntasks / first) / first > formfactor); i++)
	mov	eax, DWORD PTR -120[rbp]	# Grid$1, %sfp
	xor	edx, edx	# tmp326
	div	r9d	# Grid$0
	mov	ecx, eax	# Grid$1, Grid$1
# stencil_template_parallel.c:613:     for (int i = 0; (i < Nf) && ((Ntasks / first) / first > formfactor); i++)
	cmp	r8, rsi	# ivtmp.529, _381
	jne	.L393	#,
.L315:
# stencil_template_parallel.c:616:     if ((*S)[_x_] > (*S)[_y_])
	cmp	r13d, r14d	# _26, _27
	jbe	.L311	#,
	mov	eax, r9d	# Grid$0, Grid$0
	mov	r9d, ecx	# Grid$0, Grid$1
	mov	ecx, eax	# Grid$1, Grid$0
	jmp	.L311	#
.L388:
# stencil_template_parallel.c:578:     if (Me == 0)
	mov	r11d, DWORD PTR -72[rbp]	#, %sfp
# stencil_template_parallel.c:549:     return 1;
	mov	DWORD PTR -68[rbp], 1	# %sfp,
# stencil_template_parallel.c:578:     if (Me == 0)
	test	r11d, r11d	#
	jne	.L284	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	mov	rcx, QWORD PTR stderr[rip]	#, stderr
	mov	edx, 38	#,
	mov	esi, 1	#,
	lea	rdi, .LC24[rip]	# tmp290,
	call	fwrite@PLT	#
	jmp	.L284	#
.L329:
# stencil_template_parallel.c:645:       neighbours[EAST] = (X < Grid[_x_] - 1 ? Me + 1 : MPI_PROC_NULL);
	mov	r11d, DWORD PTR -72[rbp]	# Me, %sfp
# stencil_template_parallel.c:645:       neighbours[EAST] = (X < Grid[_x_] - 1 ? Me + 1 : MPI_PROC_NULL);
	lea	edx, -1[r9]	# tmp341,
# stencil_template_parallel.c:645:       neighbours[EAST] = (X < Grid[_x_] - 1 ? Me + 1 : MPI_PROC_NULL);
	cmp	edi, edx	# _58, tmp341
	lea	eax, 1[r11]	# tmp384,
	mov	edx, -2	# tmp385,
	cmovnb	eax, edx	# tmp384,, iftmp.115_144, tmp385
# stencil_template_parallel.c:645:       neighbours[EAST] = (X < Grid[_x_] - 1 ? Me + 1 : MPI_PROC_NULL);
	mov	rdx, QWORD PTR -128[rbp]	# neighbours, %sfp
	mov	DWORD PTR 8[rdx], eax	# MEM[(int *)neighbours_206(D) + 8B], iftmp.115_144
# stencil_template_parallel.c:646:       neighbours[WEST] = (X > 0 ? (Me - 1) % Ntasks : MPI_PROC_NULL);
	mov	edx, -2	# iftmp.117_145,
	test	r12d, r12d	# X
	jle	.L333	#,
# stencil_template_parallel.c:646:       neighbours[WEST] = (X > 0 ? (Me - 1) % Ntasks : MPI_PROC_NULL);
	lea	eax, -1[r11]	# tmp342,
# stencil_template_parallel.c:646:       neighbours[WEST] = (X > 0 ? (Me - 1) % Ntasks : MPI_PROC_NULL);
	cdq
	idiv	DWORD PTR -120[rbp]	# %sfp
.L333:
# stencil_template_parallel.c:646:       neighbours[WEST] = (X > 0 ? (Me - 1) % Ntasks : MPI_PROC_NULL);
	mov	rax, QWORD PTR -128[rbp]	# neighbours, %sfp
	mov	DWORD PTR 12[rax], edx	# MEM[(int *)neighbours_206(D) + 12B], iftmp.117_145
	jmp	.L326	#
.L335:
# stencil_template_parallel.c:660:       neighbours[NORTH] = (Y > 0 ? Me - Grid[_x_] : MPI_PROC_NULL);
	mov	r11d, DWORD PTR -72[rbp]	# Me, %sfp
	mov	edx, -2	# tmp387,
	mov	eax, r11d	# tmp386, Me
	sub	eax, r9d	# tmp386, Grid$0
	test	ebx, ebx	# Y
	cmovle	eax, edx	# tmp386,, iftmp.120_146, tmp387
# stencil_template_parallel.c:660:       neighbours[NORTH] = (Y > 0 ? Me - Grid[_x_] : MPI_PROC_NULL);
	mov	r10, QWORD PTR -128[rbp]	# neighbours, %sfp
# stencil_template_parallel.c:661:       neighbours[SOUTH] = (Y < Grid[_y_] - 1 ? Me + Grid[_x_] : MPI_PROC_NULL);
	lea	r8d, -1[rcx]	# tmp354,
# stencil_template_parallel.c:660:       neighbours[NORTH] = (Y > 0 ? Me - Grid[_x_] : MPI_PROC_NULL);
	mov	DWORD PTR [r10], eax	# *neighbours_206(D), iftmp.120_146
# stencil_template_parallel.c:661:       neighbours[SOUTH] = (Y < Grid[_y_] - 1 ? Me + Grid[_x_] : MPI_PROC_NULL);
	cmp	r8d, esi	# tmp354, _59
	lea	eax, [r9+r11]	# tmp393,
	cmovbe	eax, edx	# tmp393,, iftmp.122_147, tmp387
# stencil_template_parallel.c:661:       neighbours[SOUTH] = (Y < Grid[_y_] - 1 ? Me + Grid[_x_] : MPI_PROC_NULL);
	mov	DWORD PTR 4[r10], eax	# MEM[(int *)neighbours_206(D) + 4B], iftmp.122_147
	jmp	.L334	#
.L317:
# stencil_template_parallel.c:754:   uint *_factors_ = (uint *)malloc(N * sizeof(uint));
	movsx	rdi, r12d	# N, N
	sal	rdi, 2	# tmp307,
	mov	DWORD PTR -96[rbp], r10d	# %sfp, f
	vmovsd	QWORD PTR -104[rbp], xmm0	# %sfp, iftmp.100_51
	call	malloc@PLT	#
	mov	esi, DWORD PTR -120[rbp]	# _A_, %sfp
	vmovsd	xmm0, QWORD PTR -104[rbp]	# iftmp.100_51, %sfp
	mov	r10d, DWORD PTR -96[rbp]	# f, %sfp
	mov	r8, rax	# _factors_, tmp421
# stencil_template_parallel.c:756:   N = 0;
	xor	r9d, r9d	# N
# stencil_template_parallel.c:757:   f = 2;
	mov	ecx, 2	# f,
	vxorps	xmm2, xmm2, xmm2	# tmp422
.L319:
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	mov	eax, esi	# tmp320, _A_
	xor	edx, edx	# tmp319
	div	ecx	# f
	lea	edi, 1[r9]	# tmp309,
	movsx	rdi, edi	# ivtmp.533, tmp309
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	test	edx, edx	# tmp319
	jne	.L323	#,
	.p2align 4,,10
	.p2align 3
.L320:
# stencil_template_parallel.c:765:       _A_ /= f;
	mov	eax, esi	# _A_, _A_
	xor	edx, edx	# tmp311
	div	ecx	# f
# stencil_template_parallel.c:764:       _factors_[N++] = f;
	mov	DWORD PTR -4[r8+rdi*4], ecx	# MEM[(uint *)_factors__295 + -4B + ivtmp.533_219 * 4], f
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	xor	edx, edx	# tmp313
# stencil_template_parallel.c:764:       _factors_[N++] = f;
	mov	r9d, edi	# N, ivtmp.533
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	inc	rdi	# ivtmp.533
# stencil_template_parallel.c:765:       _A_ /= f;
	mov	esi, eax	# _A_, _A_
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	div	ecx	# f
# stencil_template_parallel.c:762:     while (_A_ % f == 0)
	test	edx, edx	# tmp313
	je	.L320	#,
.L323:
# stencil_template_parallel.c:767:     f++;
	lea	eax, 1[rcx]	# f,
# stencil_template_parallel.c:760:   while (f < A)
	cmp	ecx, ebx	# f, f
	je	.L321	#,
	mov	ecx, eax	# f, f
	jmp	.L319	#
.L390:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	mov	edx, r9d	#, Grid$0
	lea	rsi, .LC25[rip]	# tmp366,
	mov	edi, 1	#,
	xor	eax, eax	#
	call	__printf_chk@PLT	#
# stencil_template_parallel.c:695:       fflush(stdout);
	mov	rdi, QWORD PTR stdout[rip]	#, stdout
	call	fflush@PLT	#
	jmp	.L339	#
.L392:
# stencil_template_parallel.c:728: }
	call	__stack_chk_fail@PLT	#
.L324:
# stencil_template_parallel.c:616:     if ((*S)[_x_] > (*S)[_y_])
	cmp	r13d, r14d	# _26, _27
	jbe	.L383	#,
# stencil_template_parallel.c:622:   (*N)[_x_] = Grid[_x_];
	mov	rax, QWORD PTR -160[rbp]	# N, %sfp
	mov	r9d, DWORD PTR -120[rbp]	# Ntasks, %sfp
# stencil_template_parallel.c:623:   (*N)[_y_] = Grid[_y_];
	mov	DWORD PTR 4[rax], 1	# (*N_199(D))[1],
# stencil_template_parallel.c:622:   (*N)[_x_] = Grid[_x_];
	mov	DWORD PTR [rax], r9d	# (*N_199(D))[0], Ntasks
# stencil_template_parallel.c:628:   int X = Me % Grid[_x_];
	mov	eax, DWORD PTR -72[rbp]	# tmp374, %sfp
	xor	edx, edx	# _58
	div	r9d	# Ntasks
# stencil_template_parallel.c:629:   int Y = Me / Grid[_x_];
	mov	ecx, 1	# Grid$1,
# stencil_template_parallel.c:628:   int X = Me % Grid[_x_];
	mov	edi, edx	# _58, _58
# stencil_template_parallel.c:628:   int X = Me % Grid[_x_];
	mov	r12d, edx	# X, _58
# stencil_template_parallel.c:629:   int Y = Me / Grid[_x_];
	mov	esi, eax	# _59, tmp374
# stencil_template_parallel.c:629:   int Y = Me / Grid[_x_];
	mov	ebx, eax	# Y, _59
	jmp	.L328	#
	.cfi_endproc
.LFE73:
	.size	initialize, .-initialize
	.p2align 4
	.globl	memory_release
	.type	memory_release, @function
memory_release:
.LFB77:
	.cfi_startproc
	endbr64	
# stencil_template_parallel.c:969:   if (planes != NULL)
	test	rdi, rdi	# planes
	je	.L406	#,
# stencil_template_parallel.c:967: {
	push	rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	rbx, rdi	# planes, tmp88
# stencil_template_parallel.c:971:     if (planes[OLD].data != NULL)
	mov	rdi, QWORD PTR [rdi]	# _1, planes_5(D)->data
# stencil_template_parallel.c:971:     if (planes[OLD].data != NULL)
	test	rdi, rdi	# _1
	je	.L397	#,
# stencil_template_parallel.c:973:       free(planes[OLD].data);
	call	free@PLT	#
.L397:
# stencil_template_parallel.c:976:     if (planes[NEW].data != NULL)
	mov	rdi, QWORD PTR 16[rbx]	# _2, MEM[(struct plane_t *)planes_5(D) + 16B].data
# stencil_template_parallel.c:976:     if (planes[NEW].data != NULL)
	test	rdi, rdi	# _2
	je	.L396	#,
# stencil_template_parallel.c:978:       free(planes[NEW].data);
	call	free@PLT	#
.L396:
# stencil_template_parallel.c:983: }
	xor	eax, eax	#
	pop	rbx	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L406:
	.cfi_restore 3
	xor	eax, eax	#
	ret	
	.cfi_endproc
.LFE77:
	.size	memory_release, .-memory_release
	.section	.rodata.str1.1
.LC28:
	.string	" [ step %4d ] "
	.section	.rodata.str1.8
	.align 8
.LC29:
	.string	"total injected energy is %g, system energy is %g ( in avg %g per grid point)\n"
	.text
	.p2align 4
	.globl	output_energy_stat
	.type	output_energy_stat, @function
output_energy_stat:
.LFB78:
	.cfi_startproc
	endbr64	
	push	r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	vmovq	r14, xmm0	# budget, tmp124
	push	r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	mov	r13d, edi	# step, tmp122
	lea	rdi, get_total_energy._omp_fn.0[rip]	# tmp109,
	push	r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	mov	r12, rcx	# Comm, tmp126
	xor	ecx, ecx	#
	push	rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	mov	ebp, edx	# Me, tmp125
	xor	edx, edx	#
	push	rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	mov	rbx, rsi	# plane, tmp123
	sub	rsp, 64	#,
	.cfi_def_cfa_offset 112
# stencil_template_parallel.c:986: {
	mov	rax, QWORD PTR fs:40	# tmp129, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR 56[rsp], rax	# D.14388, tmp129
	xor	eax, eax	# tmp129
# ../include/stencil_template_parallel.h:228:     const int register xsize = plane->size[_x_];
	vmovq	xmm0, QWORD PTR 8[rsi]	# vect__26.558, MEM <vector(2) unsigned int> [(unsigned int *)plane_14(D) + 8B]
# ../include/stencil_template_parallel.h:232:     double *restrict data = plane->data;
	mov	rax, QWORD PTR [rsi]	# data, plane_14(D)->data
	lea	rsi, 16[rsp]	# tmp108,
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	mov	QWORD PTR 16[rsp], rax	# .omp_data_o.21.data, data
# ../include/stencil_template_parallel.h:230:     const int register fsize = xsize + 2;
	vmovd	eax, xmm0	# tmp106, vect__26.558
	add	eax, 2	# tmp107,
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	vmovq	QWORD PTR 32[rsp], xmm0	# MEM <const vector(2) int> [(int *)&.omp_data_o.21 + 16B], vect__26.558
# stencil_template_parallel.c:988:   double system_energy = 0;
	mov	QWORD PTR [rsp], 0x000000000	# system_energy,
# stencil_template_parallel.c:989:   double tot_system_energy = 0;
	mov	QWORD PTR 8[rsp], 0x000000000	# tot_system_energy,
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	mov	QWORD PTR 24[rsp], 0x000000000	# .omp_data_o.21.totenergy,
# ../include/stencil_template_parallel.h:230:     const int register fsize = xsize + 2;
	mov	DWORD PTR 40[rsp], eax	# .omp_data_o.21.fsize, tmp107
	call	GOMP_parallel@PLT	#
# ../include/stencil_template_parallel.h:247: #pragma omp parallel for reduction(+ : totenergy) schedule(static)
	vmovsd	xmm0, QWORD PTR 24[rsp]	# totenergy, .omp_data_o.21.totenergy
# stencil_template_parallel.c:992:   MPI_Reduce(&system_energy, &tot_system_energy, 1, MPI_DOUBLE, MPI_SUM, 0, *Comm);
	lea	rsi, 8[rsp]	# tmp110,
# ../include/stencil_template_parallel.h:254:     *energy = (double)totenergy;
	vmovsd	QWORD PTR [rsp], xmm0	# system_energy, totenergy
# stencil_template_parallel.c:992:   MPI_Reduce(&system_energy, &tot_system_energy, 1, MPI_DOUBLE, MPI_SUM, 0, *Comm);
	mov	rdi, rsp	# tmp111,
	sub	rsp, 8	#,
	.cfi_def_cfa_offset 120
	push	QWORD PTR [r12]	# *Comm_16(D)
	.cfi_def_cfa_offset 128
	mov	edx, 1	#,
	xor	r9d, r9d	#
	lea	r8, ompi_mpi_op_sum[rip]	#,
	lea	rcx, ompi_mpi_double[rip]	# tmp112,
	call	MPI_Reduce@PLT	#
# stencil_template_parallel.c:994:   if (Me == 0)
	pop	rax	#
	.cfi_def_cfa_offset 120
	pop	rdx	#
	.cfi_def_cfa_offset 112
	test	ebp, ebp	# Me
	jne	.L410	#,
# stencil_template_parallel.c:996:     if (step >= 0)
	test	r13d, r13d	# step
	jns	.L414	#,
.L411:
# stencil_template_parallel.c:998:     fflush(stdout);
	mov	rdi, QWORD PTR stdout[rip]	#, stdout
	call	fflush@PLT	#
# stencil_template_parallel.c:1005:            tot_system_energy / (plane->size[_x_] * plane->size[_y_]));
	mov	eax, DWORD PTR 8[rbx]	# plane_14(D)->size[0], plane_14(D)->size[0]
# stencil_template_parallel.c:1000:     printf("total injected energy is %g, "
	vxorps	xmm2, xmm2, xmm2	# tmp127
# stencil_template_parallel.c:1005:            tot_system_energy / (plane->size[_x_] * plane->size[_y_]));
	imul	eax, DWORD PTR 12[rbx]	# tmp115, plane_14(D)->size[1]
# stencil_template_parallel.c:1000:     printf("total injected energy is %g, "
	vmovsd	xmm1, QWORD PTR 8[rsp]	# tot_system_energy.146_3, tot_system_energy
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	vmovq	xmm0, r14	#, budget
# stencil_template_parallel.c:1000:     printf("total injected energy is %g, "
	vcvtusi2sd	xmm2, xmm2, eax	# tmp128, tmp127, tmp115
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	lea	rsi, .LC29[rip]	# tmp119,
	mov	edi, 1	#,
	mov	eax, 3	#,
	vdivsd	xmm2, xmm1, xmm2	#, tot_system_energy.146_3, tmp117
	call	__printf_chk@PLT	#
.L410:
# stencil_template_parallel.c:1009: }
	mov	rax, QWORD PTR 56[rsp]	# tmp130, D.14388
	sub	rax, QWORD PTR fs:40	# tmp130, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L415	#,
	add	rsp, 64	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	pop	rbx	#
	.cfi_def_cfa_offset 40
	pop	rbp	#
	.cfi_def_cfa_offset 32
	pop	r12	#
	.cfi_def_cfa_offset 24
	pop	r13	#
	.cfi_def_cfa_offset 16
	xor	eax, eax	#
	pop	r14	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L414:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	mov	edx, r13d	#, step
	lea	rsi, .LC28[rip]	# tmp113,
	mov	edi, 1	#,
	xor	eax, eax	#
	call	__printf_chk@PLT	#
	jmp	.L411	#
.L415:
# stencil_template_parallel.c:1009: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE78:
	.size	output_energy_stat, .-output_energy_stat
	.section	.rodata.str1.8
	.align 8
.LC30:
	.string	"MPI_thread level obtained is %d instead of %d\n"
	.section	.rodata.str1.1
.LC31:
	.string	"task %d is initialized\n"
	.section	.rodata.str1.8
	.align 8
.LC32:
	.string	"task %d is opting out with termination code %d\n"
	.align 8
.LC33:
	.string	"---------Rank: %d \t Elapsed time:%.6f---------\n"
	.section	.rodata.str1.1
.LC34:
	.string	"Comp time,Comms time"
.LC35:
	.string	"%.6f,%.6f\n\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB66:
	.cfi_startproc
	endbr64	
	push	r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
# stencil_template_parallel.c:41:     MPI_Init_thread(&argc, &argv, MPI_THREAD_FUNNELED, &level_obtained); // MPI_THREAD_FUNNELED: the process may be multi-threaded, but only the main thread will make MPI calls (this is the default level of thread support)
	mov	edx, 1	#,
# stencil_template_parallel.c:16: {
	push	r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 424	#,
	.cfi_def_cfa_offset 480
# stencil_template_parallel.c:16: {
	mov	DWORD PTR 92[rsp], edi	# argc, argc
	mov	QWORD PTR 80[rsp], rsi	# argv, argv
# stencil_template_parallel.c:41:     MPI_Init_thread(&argc, &argv, MPI_THREAD_FUNNELED, &level_obtained); // MPI_THREAD_FUNNELED: the process may be multi-threaded, but only the main thread will make MPI calls (this is the default level of thread support)
	lea	r15, 176[rsp]	# tmp435,
	lea	rsi, 80[rsp]	# tmp248,
	lea	rdi, 92[rsp]	# tmp249,
	mov	rcx, r15	#, tmp435
# stencil_template_parallel.c:16: {
	mov	rax, QWORD PTR fs:40	# tmp455, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR 408[rsp], rax	# D.14478, tmp455
	xor	eax, eax	# tmp455
# stencil_template_parallel.c:41:     MPI_Init_thread(&argc, &argv, MPI_THREAD_FUNNELED, &level_obtained); // MPI_THREAD_FUNNELED: the process may be multi-threaded, but only the main thread will make MPI calls (this is the default level of thread support)
	call	MPI_Init_thread@PLT	#
# stencil_template_parallel.c:42:     if (level_obtained < MPI_THREAD_FUNNELED)
	mov	edx, DWORD PTR 176[rsp]	# level_obtained.24_1, MEM[(int *)_179]
# stencil_template_parallel.c:42:     if (level_obtained < MPI_THREAD_FUNNELED)
	test	edx, edx	# level_obtained.24_1
	jle	.L454	#,
# stencil_template_parallel.c:50:     MPI_Comm_rank(MPI_COMM_WORLD, &Rank);
	lea	rbp, ompi_mpi_comm_world[rip]	# tmp252,
	lea	rsi, 96[rsp]	# tmp251,
	mov	rdi, rbp	#, tmp252
	call	MPI_Comm_rank@PLT	#
# stencil_template_parallel.c:52:     MPI_Comm_dup(MPI_COMM_WORLD, &myCOMM_WORLD);
	lea	rbx, 128[rsp]	# tmp442,
# stencil_template_parallel.c:51:     MPI_Comm_size(MPI_COMM_WORLD, &Ntasks);
	lea	rsi, 100[rsp]	# tmp253,
	mov	rdi, rbp	#, tmp252
	call	MPI_Comm_size@PLT	#
# stencil_template_parallel.c:52:     MPI_Comm_dup(MPI_COMM_WORLD, &myCOMM_WORLD);
	mov	rsi, rbx	#, tmp442
	mov	rdi, rbp	#, tmp252
	mov	QWORD PTR 72[rsp], rbx	# %sfp, tmp442
	call	MPI_Comm_dup@PLT	#
# stencil_template_parallel.c:56:   int ret = initialize(&myCOMM_WORLD, Rank, Ntasks, argc, argv, &S, &N, &periodic, &output_energy_stat_perstep,
	sub	rsp, 8	#,
	.cfi_def_cfa_offset 488
	lea	rax, 280[rsp]	# tmp441,
	mov	QWORD PTR 16[rsp], rax	# %sfp, tmp441
	push	rax	# tmp441
	.cfi_def_cfa_offset 496
	mov	rdi, rbx	#, tmp442
	lea	rax, 256[rsp]	# tmp440,
	mov	QWORD PTR 56[rsp], rax	# %sfp, tmp440
	push	rax	# tmp440
	.cfi_def_cfa_offset 504
	lea	rax, 168[rsp]	# tmp265,
	push	rax	# tmp265
	.cfi_def_cfa_offset 512
	lea	rax, 168[rsp]	# tmp266,
	push	rax	# tmp266
	.cfi_def_cfa_offset 520
	lea	rax, 156[rsp]	# tmp267,
	push	rax	# tmp267
	.cfi_def_cfa_offset 528
	lea	rax, 160[rsp]	# tmp268,
	push	rax	# tmp268
	.cfi_def_cfa_offset 536
	lea	rax, 160[rsp]	# tmp269,
	push	rax	# tmp269
	.cfi_def_cfa_offset 544
	lea	rax, 288[rsp]	# tmp439,
	mov	QWORD PTR 88[rsp], rax	# %sfp, tmp439
	push	rax	# tmp439
	.cfi_def_cfa_offset 552
	lea	rax, 192[rsp]	# tmp271,
	push	rax	# tmp271
	.cfi_def_cfa_offset 560
	lea	rax, 188[rsp]	# tmp272,
	push	rax	# tmp272
	.cfi_def_cfa_offset 568
	lea	rax, 304[rsp]	# tmp438,
	mov	QWORD PTR 136[rsp], rax	# %sfp, tmp438
	push	rax	# tmp438
	.cfi_def_cfa_offset 576
	mov	esi, DWORD PTR 192[rsp]	#, Rank
	mov	r8, QWORD PTR 176[rsp]	#, argv
	mov	ecx, DWORD PTR 188[rsp]	#, argc
	mov	edx, DWORD PTR 196[rsp]	#, Ntasks
	lea	r9, 304[rsp]	#,
	call	initialize	#
	mov	DWORD PTR 96[rsp], eax	# %sfp, current
	mov	ebx, eax	# current, tmp445
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	add	rsp, 96	#,
	.cfi_def_cfa_offset 480
	mov	edx, DWORD PTR 96[rsp]	#, Rank
	xor	eax, eax	#
	lea	rsi, .LC31[rip]	# tmp275,
	mov	edi, 1	#,
	call	__printf_chk@PLT	#
# stencil_template_parallel.c:65:   if (ret)
	test	ebx, ebx	# current
	jne	.L455	#,
# stencil_template_parallel.c:75:   double t1 = MPI_Wtime(); /* take wall-clock time */
	call	MPI_Wtime@PLT	#
# stencil_template_parallel.c:78:   for (int iter = 0; iter < Niterations; ++iter)
	cmp	DWORD PTR 104[rsp], 0	# Niterations,
# stencil_template_parallel.c:76:   double comm_time = 0;
	mov	QWORD PTR 160[rsp], 0x000000000	# comm_time,
# stencil_template_parallel.c:75:   double t1 = MPI_Wtime(); /* take wall-clock time */
	vmovsd	QWORD PTR 152[rsp], xmm0	# t1, tmp446
# stencil_template_parallel.c:78:   for (int iter = 0; iter < Niterations; ++iter)
	jle	.L421	#,
	lea	rax, 336[rsp]	# tmp436,
# stencil_template_parallel.c:78:   for (int iter = 0; iter < Niterations; ++iter)
	mov	DWORD PTR 88[rsp], 0	# %sfp,
	mov	QWORD PTR 56[rsp], rax	# %sfp, tmp436
	mov	QWORD PTR 16[rsp], r15	# %sfp, tmp435
	lea	r13, ompi_request_null[rip]	# tmp431,
	.p2align 4,,10
	.p2align 3
.L420:
# stencil_template_parallel.c:89:     inject_energy(periodic, Nsources_local, Sources_local, energy_per_source, &planes[current], N);
	movsx	r15, DWORD PTR [rsp]	# current, %sfp
	mov	rax, QWORD PTR 40[rsp]	# tmp440, %sfp
	mov	rcx, r15	# tmp388, current
	sal	rcx, 4	# tmp388,
# ../include/stencil_template_parallel.h:90:     const uint register sizex = plane->size[_x_] + 2;
	lea	rdi, 416[rcx]	# tmp544,
	mov	r12d, DWORD PTR 248[rsp+rcx]	# _183, MEM <struct plane_t[2]> [(struct plane_t *)&planes][current_273].size[0]
# stencil_template_parallel.c:89:     inject_energy(periodic, Nsources_local, Sources_local, energy_per_source, &planes[current], N);
	mov	edx, DWORD PTR 116[rsp]	# Nsources_local.34_12, Nsources_local
# ../include/stencil_template_parallel.h:90:     const uint register sizex = plane->size[_x_] + 2;
	lea	rbx, [rsp+rdi]	# tmp391,
# stencil_template_parallel.c:89:     inject_energy(periodic, Nsources_local, Sources_local, energy_per_source, &planes[current], N);
	lea	rbp, [rax+rcx]	# _9,
# stencil_template_parallel.c:85:       reqs[i] = MPI_REQUEST_NULL;
	mov	QWORD PTR 336[rsp], r13	# reqs[0], tmp431
	mov	QWORD PTR 344[rsp], r13	# reqs[1], tmp431
	mov	QWORD PTR 352[rsp], r13	# reqs[2], tmp431
	mov	QWORD PTR 360[rsp], r13	# reqs[3], tmp431
	mov	QWORD PTR 368[rsp], r13	# reqs[4], tmp431
	mov	QWORD PTR 376[rsp], r13	# reqs[5], tmp431
	mov	QWORD PTR 384[rsp], r13	# reqs[6], tmp431
	mov	QWORD PTR 392[rsp], r13	# reqs[7], tmp431
# ../include/stencil_template_parallel.h:90:     const uint register sizex = plane->size[_x_] + 2;
	mov	QWORD PTR 32[rsp], rbx	# %sfp, tmp391
# stencil_template_parallel.c:89:     inject_energy(periodic, Nsources_local, Sources_local, energy_per_source, &planes[current], N);
	vmovsd	xmm1, QWORD PTR 144[rsp]	# energy_per_source.32_10, energy_per_source
	mov	rax, QWORD PTR 136[rsp]	# Sources_local.33_11, Sources_local
	mov	r8d, DWORD PTR 108[rsp]	# periodic.35_13, periodic
# ../include/stencil_template_parallel.h:91:     double *restrict data = plane->data;
	mov	rdi, QWORD PTR 240[rsp+rcx]	# data, MEM <struct plane_t[2]> [(struct plane_t *)&planes][current_273].data
# ../include/stencil_template_parallel.h:90:     const uint register sizex = plane->size[_x_] + 2;
	lea	r9d, 2[r12]	# sizex,
# ../include/stencil_template_parallel.h:94:     for (int s = 0; s < Nsources; s++)
	test	edx, edx	# Nsources_local.34_12
	jle	.L439	#,
	dec	edx	# tmp280
	mov	QWORD PTR 64[rsp], rbp	# %sfp, _9
# ../include/stencil_template_parallel.h:103:             if ((N[_x_] == 1))
	mov	ebx, DWORD PTR 216[rsp]	# _199, MEM[(const uint *)&N]
# ../include/stencil_template_parallel.h:119:             if ((N[_y_] == 1))
	mov	r11d, DWORD PTR 220[rsp]	# _213, MEM[(const uint *)&N + 4B]
	lea	r10, 8[rax+rdx*8]	# _257,
	mov	r14d, r12d	# _183, _183
	jmp	.L430	#
	.p2align 4,,10
	.p2align 3
.L425:
# ../include/stencil_template_parallel.h:119:             if ((N[_y_] == 1))
	cmp	r11d, 1	# _213,
	je	.L456	#,
.L423:
# ../include/stencil_template_parallel.h:94:     for (int s = 0; s < Nsources; s++)
	add	rax, 8	# ivtmp.608,
	cmp	r10, rax	# _257, ivtmp.608
	je	.L457	#,
.L430:
# ../include/stencil_template_parallel.h:97:         int y = Sources[s][_y_];
	mov	ecx, DWORD PTR 4[rax]	# _191, MEM[(unsigned int *)_361 + 4B]
# ../include/stencil_template_parallel.h:99:         data[IDX(x, y)] += energy;
	mov	esi, r9d	# _192, sizex
	imul	esi, ecx	# _192, _191
# ../include/stencil_template_parallel.h:96:         int x = Sources[s][_x_];
	mov	edx, DWORD PTR [rax]	#, MEM[(unsigned int *)_361]
# ../include/stencil_template_parallel.h:99:         data[IDX(x, y)] += energy;
	lea	r12d, [rdx+rsi]	# tmp284,
	lea	r12, [rdi+r12*8]	# _196,
	vaddsd	xmm0, xmm1, QWORD PTR [r12]	# tmp286, energy_per_source.32_10, *_196
	vmovsd	QWORD PTR [r12], xmm0	# *_196, tmp286
# ../include/stencil_template_parallel.h:101:         if (periodic)
	test	r8d, r8d	# periodic.35_13
	je	.L423	#,
# ../include/stencil_template_parallel.h:103:             if ((N[_x_] == 1))
	cmp	ebx, 1	# _199,
	jne	.L425	#,
# ../include/stencil_template_parallel.h:108:                 if (x == 1)
	cmp	edx, 1	# _190,
	jne	.L426	#,
# ../include/stencil_template_parallel.h:110:                     data[IDX(sizex - 1, y)] += energy;
	lea	r12d, -1[r9+rsi]	# tmp290,
	lea	r12, [rdi+r12*8]	# _205,
	vaddsd	xmm0, xmm1, QWORD PTR [r12]	# tmp292, energy_per_source.32_10, *_205
	vmovsd	QWORD PTR [r12], xmm0	# *_205, tmp292
.L426:
# ../include/stencil_template_parallel.h:113:                 if (x == sizex - 2)
	cmp	r14d, edx	# _183, _190
	jne	.L425	#,
# ../include/stencil_template_parallel.h:115:                     data[IDX(0, y)] += energy;
	mov	r12d, esi	# _192, _192
	lea	r12, [rdi+r12*8]	# _210,
	vaddsd	xmm0, xmm1, QWORD PTR [r12]	# tmp296, energy_per_source.32_10, *_210
	vmovsd	QWORD PTR [r12], xmm0	# *_210, tmp296
# ../include/stencil_template_parallel.h:119:             if ((N[_y_] == 1))
	cmp	r11d, 1	# _213,
	jne	.L423	#,
	.p2align 4,,10
	.p2align 3
.L456:
# ../include/stencil_template_parallel.h:126:                     data[IDX(x, plane->size[_y_] + 1)] += energy;
	mov	r12, QWORD PTR 32[rsp]	# tmp391, %sfp
	mov	r12d, DWORD PTR -164[r12]	# pretmp_398, MEM <struct plane_t[2]> [(struct plane_t *)&planes][current_273].size[1]
# ../include/stencil_template_parallel.h:124:                 if (y == 1)
	cmp	ecx, 1	# _191,
	jne	.L429	#,
# ../include/stencil_template_parallel.h:126:                     data[IDX(x, plane->size[_y_] + 1)] += energy;
	lea	ebp, 1[r12]	# tmp302,
	imul	esi, ebp	# tmp303, tmp302
	add	esi, edx	# tmp305, _190
	mov	esi, esi	# tmp305, tmp305
	lea	rsi, [rdi+rsi*8]	# _220,
	vaddsd	xmm0, xmm1, QWORD PTR [rsi]	# tmp307, energy_per_source.32_10, *_220
	vmovsd	QWORD PTR [rsi], xmm0	# *_220, tmp307
.L429:
# ../include/stencil_template_parallel.h:129:                 if (y == plane->size[_y_])
	cmp	ecx, r12d	# _191, pretmp_398
	jne	.L423	#,
# ../include/stencil_template_parallel.h:131:                     data[IDX(x, 0)] += energy;
	lea	rdx, [rdi+rdx*8]	# _226,
	vaddsd	xmm0, xmm1, QWORD PTR [rdx]	# tmp311, energy_per_source.32_10, *_226
# ../include/stencil_template_parallel.h:94:     for (int s = 0; s < Nsources; s++)
	add	rax, 8	# ivtmp.608,
# ../include/stencil_template_parallel.h:131:                     data[IDX(x, 0)] += energy;
	vmovsd	QWORD PTR [rdx], xmm0	# *_226, tmp311
# ../include/stencil_template_parallel.h:94:     for (int s = 0; s < Nsources; s++)
	cmp	r10, rax	# _257, ivtmp.608
	jne	.L430	#,
	.p2align 4,,10
	.p2align 3
.L457:
	mov	rbp, QWORD PTR 64[rsp]	# _9, %sfp
.L439:
# stencil_template_parallel.c:95:     fill_buffers(&planes[current], neighbours, N, buffers, periodic);
	mov	r12, QWORD PTR 8[rsp]	# tmp441, %sfp
	mov	r14, QWORD PTR 24[rsp]	# tmp439, %sfp
	mov	rdx, QWORD PTR 48[rsp]	#, %sfp
	mov	rcx, r12	#, tmp441
	mov	rsi, r14	#, tmp439
	mov	rdi, rbp	#, _9
	xor	eax, eax	#
	call	fill_buffers	#
# stencil_template_parallel.c:102:     double t_start = MPI_Wtime();
	call	MPI_Wtime@PLT	#
# stencil_template_parallel.c:103:     halo_communications(&planes[current], neighbours, buffers, &myCOMM_WORLD, reqs);
	mov	r8, QWORD PTR 56[rsp]	#, %sfp
	mov	rcx, QWORD PTR 72[rsp]	#, %sfp
	mov	rdx, r12	#, tmp441
	mov	rsi, r14	#, tmp439
	mov	rdi, rbp	#, _9
	xor	eax, eax	#
# stencil_template_parallel.c:102:     double t_start = MPI_Wtime();
	vmovq	rbx, xmm0	# t_start, tmp447
# stencil_template_parallel.c:103:     halo_communications(&planes[current], neighbours, buffers, &myCOMM_WORLD, reqs);
	mov	QWORD PTR 8[rsp], r12	# %sfp, tmp441
	mov	QWORD PTR 24[rsp], r14	# %sfp, tmp439
	call	halo_communications	#
# stencil_template_parallel.c:104:     comm_time += (MPI_Wtime() - t_start);
	call	MPI_Wtime@PLT	#
	mov	eax, DWORD PTR [rsp]	# current, %sfp
# stencil_template_parallel.c:104:     comm_time += (MPI_Wtime() - t_start);
	vmovq	xmm5, rbx	# t_start, t_start
	vsubsd	xmm0, xmm0, xmm5	# tmp320, tmp448, t_start
	xor	eax, 1	# current,
	movsx	r12, eax	#, current
	mov	rax, QWORD PTR 40[rsp]	# tmp440, %sfp
	sal	r15, 4	# tmp325,
	lea	rbx, [rax+r15]	# tmp326,
# stencil_template_parallel.c:104:     comm_time += (MPI_Wtime() - t_start);
	vaddsd	xmm0, xmm0, QWORD PTR 160[rsp]	# tmp321, tmp320, comm_time
# stencil_template_parallel.c:327:   const uint xsize = oldplane->size[_x_];
	vmovq	xmm1, QWORD PTR 8[rbx]	# vect_xsize_178.572, MEM <const vector(2) unsigned int> [(const struct plane_t *)vectp.571_380]
# stencil_template_parallel.c:336: #pragma omp parallel for collapse(2) schedule(static)
	vmovq	xmm3, QWORD PTR 240[rsp+r15]	# tmp499, MEM <struct plane_t[2]> [(const struct plane_t *)&planes][current_273].data
	mov	r14, r12	#,
# stencil_template_parallel.c:334:   double *restrict new = newplane->data;
	sal	r12, 4	# tmp333,
# stencil_template_parallel.c:329:   const uint fxsize = xsize + 2; // including halos
	vmovd	eax, xmm1	# tmp338, vect_xsize_178.572
	mov	rsi, QWORD PTR 16[rsp]	#, %sfp
# stencil_template_parallel.c:104:     comm_time += (MPI_Wtime() - t_start);
	vmovsd	QWORD PTR 160[rsp], xmm0	# comm_time, tmp321
# stencil_template_parallel.c:336: #pragma omp parallel for collapse(2) schedule(static)
	vpinsrq	xmm0, xmm3, QWORD PTR 240[rsp+r12], 1	# tmp327, tmp499, MEM <struct plane_t[2]> [(struct plane_t *)&planes][_49].data
# stencil_template_parallel.c:329:   const uint fxsize = xsize + 2; // including halos
	add	eax, 2	# tmp339,
	xor	ecx, ecx	#
	xor	edx, edx	#
	lea	rdi, update_inner_points._omp_fn.0[rip]	#,
# stencil_template_parallel.c:336: #pragma omp parallel for collapse(2) schedule(static)
	vmovq	QWORD PTR 192[rsp], xmm1	# MEM <const vector(2) unsigned int> [(unsigned int *)_179], vect_xsize_178.572
# stencil_template_parallel.c:329:   const uint fxsize = xsize + 2; // including halos
	mov	DWORD PTR 200[rsp], eax	# MEM[(struct .omp_data_s.65 *)_179].fxsize, tmp339
# stencil_template_parallel.c:336: #pragma omp parallel for collapse(2) schedule(static)
	vmovdqa	XMMWORD PTR 176[rsp], xmm0	# MEM <vector(2) long unsigned int> [(double * *)_179], tmp327
	call	GOMP_parallel@PLT	#
# stencil_template_parallel.c:109:     double t_start2 = MPI_Wtime();
	call	MPI_Wtime@PLT	#
# stencil_template_parallel.c:110:     MPI_Waitall(8, reqs, MPI_STATUSES_IGNORE);
	mov	rsi, QWORD PTR 56[rsp]	#, %sfp
	xor	edx, edx	#
	mov	edi, 8	#,
# stencil_template_parallel.c:109:     double t_start2 = MPI_Wtime();
	vmovsd	QWORD PTR [rsp], xmm0	# %sfp, tmp449
# stencil_template_parallel.c:110:     MPI_Waitall(8, reqs, MPI_STATUSES_IGNORE);
	call	MPI_Waitall@PLT	#
# stencil_template_parallel.c:114:     copy_halo(&planes[current], neighbours, N, buffers, periodic);
	mov	r8d, DWORD PTR 108[rsp]	#, periodic
	mov	rcx, QWORD PTR 8[rsp]	#, %sfp
	mov	rdx, QWORD PTR 48[rsp]	#, %sfp
	mov	rsi, QWORD PTR 24[rsp]	#, %sfp
	mov	rdi, rbp	#, _9
	xor	eax, eax	#
	call	copy_halo	#
# stencil_template_parallel.c:115:     comm_time += (MPI_Wtime() - t_start2);
	call	MPI_Wtime@PLT	#
# stencil_template_parallel.c:115:     comm_time += (MPI_Wtime() - t_start2);
	vsubsd	xmm0, xmm0, QWORD PTR [rsp]	# tmp347, tmp450, %sfp
# stencil_template_parallel.c:359:   double *restrict old = oldplane->data;
	mov	r15, QWORD PTR 240[rsp+r15]	# old, MEM <struct plane_t[2]> [(const struct plane_t *)&planes][current_273].data
# stencil_template_parallel.c:360:   double *restrict new = newplane->data;
	mov	r12, QWORD PTR 240[rsp+r12]	# new, MEM <struct plane_t[2]> [(struct plane_t *)&planes][_49].data
# stencil_template_parallel.c:115:     comm_time += (MPI_Wtime() - t_start2);
	vaddsd	xmm0, xmm0, QWORD PTR 160[rsp]	# tmp348, tmp347, comm_time
# stencil_template_parallel.c:120:     update_boundary_points(&planes[current], &planes[!current], periodic, N);
	mov	eax, DWORD PTR 108[rsp]	# periodic.40_23, periodic
# stencil_template_parallel.c:363: #pragma omp parallel for schedule(static)
	vmovq	xmm4, r15	# old, old
# stencil_template_parallel.c:115:     comm_time += (MPI_Wtime() - t_start2);
	vmovsd	QWORD PTR 160[rsp], xmm0	# comm_time, tmp348
# stencil_template_parallel.c:352:   const uint xsize = oldplane->size[_x_];
	vmovq	xmm0, QWORD PTR 8[rbx]	# vect_xsize_129.581, MEM <const vector(2) unsigned int> [(const struct plane_t *)vectp.571_380]
	mov	rsi, QWORD PTR 16[rsp]	#, %sfp
	vmovd	ebp, xmm0	# _394, vect_xsize_129.581
	vpextrd	r8d, xmm0, 1	# _395, vect_xsize_129.581
# stencil_template_parallel.c:363: #pragma omp parallel for schedule(static)
	vpinsrq	xmm1, xmm4, r12, 1	# tmp358, old, new
	xor	ecx, ecx	#
	xor	edx, edx	#
# stencil_template_parallel.c:354:   const uint fxsize = xsize + 2; // including halos
	lea	ebx, 2[rbp]	# fxsize,
	lea	rdi, update_boundary_points._omp_fn.0[rip]	#,
# stencil_template_parallel.c:120:     update_boundary_points(&planes[current], &planes[!current], periodic, N);
	mov	DWORD PTR 64[rsp], eax	# %sfp, periodic.40_23
	mov	DWORD PTR 32[rsp], r8d	# %sfp, _395
# stencil_template_parallel.c:363: #pragma omp parallel for schedule(static)
	vmovdqa	XMMWORD PTR 176[rsp], xmm1	# MEM <vector(2) long unsigned int> [(double * *)_179], tmp358
	vmovq	QWORD PTR 192[rsp], xmm0	# MEM <const vector(2) unsigned int> [(unsigned int *)_179], vect_xsize_129.581
	vmovq	QWORD PTR [rsp], xmm0	# %sfp, vect_xsize_129.581
	mov	DWORD PTR 200[rsp], ebx	# MEM[(struct .omp_data_s.76 *)_179].fxsize, fxsize
	call	GOMP_parallel@PLT	#
# stencil_template_parallel.c:371: #pragma omp parallel for schedule(static)
	vmovq	xmm0, QWORD PTR [rsp]	# vect_xsize_129.581, %sfp
	mov	rsi, QWORD PTR 16[rsp]	#, %sfp
	xor	ecx, ecx	#
	xor	edx, edx	#
	lea	rdi, update_boundary_points._omp_fn.1[rip]	#,
	mov	QWORD PTR 184[rsp], r12	# MEM[(struct .omp_data_s.77 *)_179].new, new
	mov	QWORD PTR 176[rsp], r15	# MEM[(struct .omp_data_s.77 *)_179].old, old
	mov	DWORD PTR 200[rsp], ebx	# MEM[(struct .omp_data_s.77 *)_179].fxsize, fxsize
	vmovq	QWORD PTR 192[rsp], xmm0	# MEM <const vector(2) unsigned int> [(unsigned int *)_179], vect_xsize_129.581
	call	GOMP_parallel@PLT	#
# stencil_template_parallel.c:378:   if (periodic)
	mov	eax, DWORD PTR 64[rsp]	# periodic.40_23, %sfp
	mov	r8d, DWORD PTR 32[rsp]	# _395, %sfp
	test	eax, eax	# periodic.40_23
	je	.L434	#,
# stencil_template_parallel.c:380:     if (N[_x_] == 1)
	mov	edx, DWORD PTR 216[rsp]	# r, MEM[(uint *)&N]
# stencil_template_parallel.c:380:     if (N[_x_] == 1)
	cmp	edx, 1	# r,
	je	.L432	#,
.L435:
# stencil_template_parallel.c:393:     if (N[_y_] == 1)
	mov	eax, DWORD PTR 220[rsp]	# c, MEM[(uint *)&N + 4B]
# stencil_template_parallel.c:393:     if (N[_y_] == 1)
	cmp	eax, 1	# c,
	je	.L458	#,
.L434:
# stencil_template_parallel.c:78:   for (int iter = 0; iter < Niterations; ++iter)
	inc	DWORD PTR 88[rsp]	# %sfp
	mov	eax, DWORD PTR 88[rsp]	# iter, %sfp
# stencil_template_parallel.c:78:   for (int iter = 0; iter < Niterations; ++iter)
	cmp	DWORD PTR 104[rsp], eax	# Niterations, iter
	jle	.L459	#,
.L443:
	mov	DWORD PTR [rsp], r14d	# %sfp, _49
	jmp	.L420	#
	.p2align 4,,10
	.p2align 3
.L458:
# stencil_template_parallel.c:398:       for (uint c = 1; c <= xsize; c++)
	test	ebp, ebp	# _394
	je	.L434	#,
# stencil_template_parallel.c:401:         new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	imul	r8d, ebx	# _156, fxsize
# stencil_template_parallel.c:402:         new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	lea	ecx, [rbx+r8]	# _171,
	.p2align 4,,10
	.p2align 3
.L437:
# stencil_template_parallel.c:401:         new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	lea	edx, [r8+rax]	# tmp372,
# stencil_template_parallel.c:401:         new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	vmovsd	xmm0, QWORD PTR [r12+rdx*8]	# _165, *_161
# stencil_template_parallel.c:401:         new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	mov	edx, eax	# c, c
# stencil_template_parallel.c:401:         new[IDX(c, 0)] = new[IDX(c, ysize)];     // copy the last row into the first ghost row
	vmovsd	QWORD PTR [r12+rdx*8], xmm0	# *_164, _165
# stencil_template_parallel.c:402:         new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	lea	edx, [rbx+rax]	# tmp375,
# stencil_template_parallel.c:402:         new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	vmovsd	xmm0, QWORD PTR [r12+rdx*8]	# _176, *_169
# stencil_template_parallel.c:402:         new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	lea	edx, [rcx+rax]	# tmp377,
# stencil_template_parallel.c:398:       for (uint c = 1; c <= xsize; c++)
	inc	eax	# c
# stencil_template_parallel.c:402:         new[IDX(c, ysize + 1)] = new[IDX(c, 1)]; // copy the first row into the last ghost row
	vmovsd	QWORD PTR [r12+rdx*8], xmm0	# *_175, _176
# stencil_template_parallel.c:398:       for (uint c = 1; c <= xsize; c++)
	cmp	eax, ebp	# c, _394
	jbe	.L437	#,
# stencil_template_parallel.c:78:   for (int iter = 0; iter < Niterations; ++iter)
	inc	DWORD PTR 88[rsp]	# %sfp
	mov	eax, DWORD PTR 88[rsp]	# iter, %sfp
# stencil_template_parallel.c:78:   for (int iter = 0; iter < Niterations; ++iter)
	cmp	DWORD PTR 104[rsp], eax	# Niterations, iter
	jg	.L443	#,
.L459:
	mov	DWORD PTR [rsp], r14d	# %sfp, _49
	mov	r15, QWORD PTR 16[rsp]	# tmp435, %sfp
.L421:
# stencil_template_parallel.c:139:   t1 = MPI_Wtime() - t1;
	call	MPI_Wtime@PLT	#
# stencil_template_parallel.c:139:   t1 = MPI_Wtime() - t1;
	vsubsd	xmm0, xmm0, QWORD PTR 152[rsp]	# _27, tmp451, t1
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	mov	edx, DWORD PTR 96[rsp]	#, Rank
	lea	rsi, .LC33[rip]	# tmp398,
	mov	edi, 1	#,
	mov	eax, 1	#,
# stencil_template_parallel.c:139:   t1 = MPI_Wtime() - t1;
	vmovsd	QWORD PTR 152[rsp], xmm0	# t1, _27
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# stencil_template_parallel.c:142:   output_energy_stat(-1, &planes[!current], Niterations * Nsources * energy_per_source, Rank, &myCOMM_WORLD);
	mov	eax, DWORD PTR 104[rsp]	# Niterations, Niterations
# stencil_template_parallel.c:142:   output_energy_stat(-1, &planes[!current], Niterations * Nsources * energy_per_source, Rank, &myCOMM_WORLD);
	vxorpd	xmm7, xmm7, xmm7	# tmp510
# stencil_template_parallel.c:142:   output_energy_stat(-1, &planes[!current], Niterations * Nsources * energy_per_source, Rank, &myCOMM_WORLD);
	imul	eax, DWORD PTR 112[rsp]	# tmp401, Nsources
# stencil_template_parallel.c:142:   output_energy_stat(-1, &planes[!current], Niterations * Nsources * energy_per_source, Rank, &myCOMM_WORLD);
	mov	esi, DWORD PTR [rsp]	# current, %sfp
	mov	rbx, QWORD PTR 40[rsp]	# tmp440, %sfp
	vcvtsi2sd	xmm0, xmm7, eax	# tmp453, tmp510, tmp401
	xor	esi, 1	# current,
	movsx	rsi, esi	# tmp407, tmp406
	mov	rcx, QWORD PTR 72[rsp]	#, %sfp
	vmulsd	xmm0, xmm0, QWORD PTR 144[rsp]	# tmp404, tmp403, energy_per_source
	mov	edx, DWORD PTR 96[rsp]	#, Rank
	sal	rsi, 4	# tmp408,
	add	rsi, rbx	# tmp409, tmp440
	or	edi, -1	#,
	call	output_energy_stat	#
# stencil_template_parallel.c:144:   memory_release(planes, buffers);
	mov	rsi, QWORD PTR 8[rsp]	#, %sfp
	mov	rdi, rbx	#, tmp440
	call	memory_release	#
# stencil_template_parallel.c:148:   MPI_Reduce(&comm_time, &comms_sum, 1, MPI_DOUBLE, MPI_SUM, 0, myCOMM_WORLD);
	lea	rsi, 168[rsp]	# tmp414,
	lea	rdi, 160[rsp]	# tmp415,
# stencil_template_parallel.c:146:   double comms_sum = 0.0;
	mov	QWORD PTR 168[rsp], 0x000000000	# comms_sum,
# stencil_template_parallel.c:147:   double comp_time = 0.0;
	mov	QWORD PTR 176[rsp], 0x000000000	# MEM[(double *)_179],
# stencil_template_parallel.c:148:   MPI_Reduce(&comm_time, &comms_sum, 1, MPI_DOUBLE, MPI_SUM, 0, myCOMM_WORLD);
	push	rax	#
	.cfi_def_cfa_offset 488
	lea	r12, ompi_mpi_double[rip]	# tmp416,
	xor	r9d, r9d	#
	push	QWORD PTR 136[rsp]	# myCOMM_WORLD
	.cfi_def_cfa_offset 496
	lea	r8, ompi_mpi_op_sum[rip]	#,
	mov	rcx, r12	#, tmp416
	mov	edx, 1	#,
	call	MPI_Reduce@PLT	#
# stencil_template_parallel.c:149:   MPI_Reduce(&t1, &comp_time, 1, MPI_DOUBLE, MPI_SUM, 0, myCOMM_WORLD);
	lea	rdi, 168[rsp]	# tmp418,
	pop	rdx	#
	.cfi_def_cfa_offset 488
	push	QWORD PTR 136[rsp]	# myCOMM_WORLD
	.cfi_def_cfa_offset 496
	xor	r9d, r9d	#
	mov	rcx, r12	#, tmp416
	mov	rsi, r15	#, tmp435
	lea	r8, ompi_mpi_op_sum[rip]	#,
	mov	edx, 1	#,
	call	MPI_Reduce@PLT	#
# stencil_template_parallel.c:151:   if (Rank == 0)
	pop	rcx	#
	.cfi_def_cfa_offset 488
	pop	rsi	#
	.cfi_def_cfa_offset 480
	cmp	DWORD PTR 96[rsp], 0	# Rank,
	je	.L460	#,
.L440:
# stencil_template_parallel.c:159:   MPI_Finalize();
	call	MPI_Finalize@PLT	#
.L419:
# stencil_template_parallel.c:161: }
	mov	rax, QWORD PTR 408[rsp]	# tmp456, D.14478
	sub	rax, QWORD PTR fs:40	# tmp456, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L461	#,
	add	rsp, 424	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx	#
	.cfi_def_cfa_offset 48
	pop	rbp	#
	.cfi_def_cfa_offset 40
	pop	r12	#
	.cfi_def_cfa_offset 32
	pop	r13	#
	.cfi_def_cfa_offset 24
	pop	r14	#
	.cfi_def_cfa_offset 16
	xor	eax, eax	#
	pop	r15	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L432:
	.cfi_restore_state
# stencil_template_parallel.c:385:       for (uint r = 1; r <= ysize; r++)
	test	r8d, r8d	# _395
	je	.L435	#,
# stencil_template_parallel.c:354:   const uint fxsize = xsize + 2; // including halos
	mov	eax, ebx	# ivtmp.601, fxsize
	lea	esi, 1[rbp]	# tmp437,
	.p2align 4,,10
	.p2align 3
.L436:
# stencil_template_parallel.c:388:         new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	lea	ecx, [rax+rbp]	# tmp364,
# stencil_template_parallel.c:388:         new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	vmovsd	xmm0, QWORD PTR [r12+rcx*8]	# _144, *_140
# stencil_template_parallel.c:388:         new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	mov	ecx, eax	# ivtmp.601, ivtmp.601
# stencil_template_parallel.c:388:         new[IDX(0, r)] = new[IDX(xsize, r)];     // copy the last column into the first ghost column
	vmovsd	QWORD PTR [r12+rcx*8], xmm0	# *_143, _144
# stencil_template_parallel.c:389:         new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	lea	ecx, 1[rax]	# tmp367,
# stencil_template_parallel.c:389:         new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	vmovsd	xmm0, QWORD PTR [r12+rcx*8]	# _153, *_148
# stencil_template_parallel.c:385:       for (uint r = 1; r <= ysize; r++)
	inc	edx	# r
# stencil_template_parallel.c:389:         new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	lea	ecx, [rsi+rax]	# tmp370,
# stencil_template_parallel.c:389:         new[IDX(xsize + 1, r)] = new[IDX(1, r)]; // copy the first column into the last ghost column
	vmovsd	QWORD PTR [r12+rcx*8], xmm0	# *_152, _153
# stencil_template_parallel.c:385:       for (uint r = 1; r <= ysize; r++)
	add	eax, ebx	# ivtmp.601, fxsize
	cmp	edx, r8d	# r, _395
	jbe	.L436	#,
	jmp	.L435	#
.L460:
# stencil_template_parallel.c:154:     MPI_Comm_size(myCOMM_WORLD, &P);
	mov	rdi, QWORD PTR 128[rsp]	#, myCOMM_WORLD
	lea	rsi, 124[rsp]	# tmp420,
	call	MPI_Comm_size@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	lea	rdi, .LC34[rip]	# tmp422,
	call	puts@PLT	#
# stencil_template_parallel.c:156:     printf("%.6f,%.6f\n\n", comp_time / (double)P, comms_sum / (double)P);
	vxorpd	xmm2, xmm2, xmm2	# tmp512
	vcvtsi2sd	xmm0, xmm2, DWORD PTR 124[rsp]	# tmp454, tmp512, P
# stencil_template_parallel.c:156:     printf("%.6f,%.6f\n\n", comp_time / (double)P, comms_sum / (double)P);
	vmovsd	xmm1, QWORD PTR 176[rsp]	# MEM[(double *)_179], MEM[(double *)_179]
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	lea	rsi, .LC35[rip]	# tmp427,
	mov	edi, 1	#,
# stencil_template_parallel.c:156:     printf("%.6f,%.6f\n\n", comp_time / (double)P, comms_sum / (double)P);
	vdivsd	xmm2, xmm1, xmm0	# tmp425, MEM[(double *)_179], _45
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	vmovsd	xmm1, QWORD PTR 168[rsp]	# comms_sum, comms_sum
	mov	eax, 2	#,
	vdivsd	xmm1, xmm1, xmm0	#, comms_sum, _45
	vmovsd	xmm0, xmm2, xmm2	#, tmp425
	call	__printf_chk@PLT	#
	jmp	.L440	#
.L455:
	mov	ecx, DWORD PTR [rsp]	#, %sfp
	mov	edx, DWORD PTR 96[rsp]	#, Rank
	lea	rsi, .LC32[rip]	# tmp277,
	mov	edi, 1	#,
	xor	eax, eax	#
	call	__printf_chk@PLT	#
# stencil_template_parallel.c:70:     MPI_Finalize();
	call	MPI_Finalize@PLT	#
# stencil_template_parallel.c:71:     return 0;
	jmp	.L419	#
.L454:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	mov	edi, 1	#,
	mov	ecx, 1	#,
	lea	rsi, .LC30[rip]	# tmp250,
	xor	eax, eax	#
	call	__printf_chk@PLT	#
# stencil_template_parallel.c:46:       MPI_Finalize();
	call	MPI_Finalize@PLT	#
# stencil_template_parallel.c:47:       exit(1);
	mov	edi, 1	#,
	call	exit@PLT	#
.L461:
# stencil_template_parallel.c:161: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE66:
	.size	main, .-main
	.section	.rodata.str1.1
.LC36:
	.string	"w"
	.text
	.p2align 4
	.globl	dump
	.type	dump, @function
dump:
.LFB79:
	.cfi_startproc
	endbr64	
# stencil_template_parallel.c:1039:   return 1;
	mov	eax, 1	# <retval>,
# stencil_template_parallel.c:1013:   if ((filename != NULL) && (filename[0] != '\0'))
	test	rdx, rdx	# filename
	je	.L485	#,
# stencil_template_parallel.c:1012: {
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	push	r15	#
	.cfi_offset 15, -24
	mov	r15, rdi	# data, tmp199
	mov	rdi, rdx	# filename, tmp201
	push	r14	#
	push	r13	#
	push	r12	#
	push	rbx	#
	and	rsp, -32	#,
	sub	rsp, 32	#,
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
# stencil_template_parallel.c:1013:   if ((filename != NULL) && (filename[0] != '\0'))
	cmp	BYTE PTR [rdx], 0	# *filename_26(D),
	jne	.L488	#,
.L462:
# stencil_template_parallel.c:1040: }
	lea	rsp, -40[rbp]	#,
	pop	rbx	#
	pop	r12	#
	pop	r13	#
	pop	r14	#
	pop	r15	#
	pop	rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
	.p2align 4,,10
	.p2align 3
.L488:
	.cfi_restore_state
	mov	rbx, rsi	# size, tmp200
# stencil_template_parallel.c:1015:     FILE *outfile = fopen(filename, "w");
	lea	rsi, .LC36[rip]	# tmp157,
	call	fopen@PLT	#
	mov	r13, rax	# outfile, tmp202
# stencil_template_parallel.c:1016:     if (outfile == NULL)
	test	rax, rax	# outfile
	je	.L477	#,
# stencil_template_parallel.c:1019:     float *array = (float *)malloc(size[0] * sizeof(float));
	mov	r9d, DWORD PTR [rbx]	#, *size_30(D)
# stencil_template_parallel.c:1019:     float *array = (float *)malloc(size[0] * sizeof(float));
	lea	rdi, 0[0+r9*4]	# tmp160,
	mov	QWORD PTR 24[rsp], r9	# %sfp, pretmp_63
# stencil_template_parallel.c:1019:     float *array = (float *)malloc(size[0] * sizeof(float));
	mov	r14, r9	#,
# stencil_template_parallel.c:1019:     float *array = (float *)malloc(size[0] * sizeof(float));
	call	malloc@PLT	#
	mov	r12, rax	# array, tmp203
# stencil_template_parallel.c:1021:     for (int j = 1; j <= size[1]; j++)
	mov	eax, DWORD PTR 4[rbx]	#, MEM[(const uint *)size_30(D) + 4B]
	test	eax, eax	#
	je	.L464	#,
# stencil_template_parallel.c:1021:     for (int j = 1; j <= size[1]; j++)
	mov	r9, QWORD PTR 24[rsp]	# pretmp_63, %sfp
	mov	r8d, 1	# j,
	.p2align 4,,10
	.p2align 3
.L474:
# stencil_template_parallel.c:1023:       const double *restrict line = data + j * (size[0] + 2);
	lea	ecx, 2[r14]	# tmp162,
# stencil_template_parallel.c:1023:       const double *restrict line = data + j * (size[0] + 2);
	imul	ecx, r8d	# _8, j
# stencil_template_parallel.c:1024:       for (int i = 1; i <= size[0]; i++)
	test	r14d, r14d	# pretmp_63
	je	.L470	#,
	lea	eax, -1[r14]	# tmp165,
	cmp	eax, 6	# tmp165,
	jbe	.L478	#,
	mov	esi, r14d	# bnd.621, pretmp_63
	shr	esi, 3	#,
	lea	rdx, 8[r15+rcx*8]	# vectp.625,
	sal	rsi, 5	# _119,
	xor	eax, eax	# ivtmp.649
	.p2align 4,,10
	.p2align 3
.L468:
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	vcvtpd2ps	xmm0, YMMWORD PTR [rdx+rax*2]	# tmp173, MEM <const vector(4) double> [(const double *)vectp.625_21 + ivtmp.649_9 * 2]
	vcvtpd2ps	xmm1, YMMWORD PTR 32[rdx+rax*2]	# tmp174, MEM <const vector(4) double> [(const double *)vectp.625_21 + 32B + ivtmp.649_9 * 2]
	vinsertf128	ymm0, ymm0, xmm1, 0x1	# vect__15.628, tmp173, tmp174
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	vmovups	YMMWORD PTR [r12+rax], ymm0	# MEM <vector(8) float> [(float *)array_32 + ivtmp.649_9 * 1], vect__15.628
	add	rax, 32	# ivtmp.649,
	cmp	rax, rsi	# ivtmp.649, _119
	jne	.L468	#,
	mov	edx, r14d	# niters_vector_mult_vf.622, pretmp_63
	and	edx, -8	#,
	lea	eax, 1[rdx]	# tmp.634,
	cmp	edx, r14d	# niters_vector_mult_vf.622, pretmp_63
	je	.L483	#,
.L467:
	mov	esi, r14d	# niters.631, pretmp_63
	sub	esi, edx	# niters.631, niters_vector_mult_vf.622
	lea	edi, -1[rsi]	# tmp175,
	cmp	edi, 2	# tmp175,
	jbe	.L472	#,
	lea	rdi, 1[rcx+rdx]	# tmp177,
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	vmovupd	xmm2, XMMWORD PTR [r15+rdi*8]	# tmp212, MEM <const vector(2) double> [(const double *)vectp.636_118]
	vinsertf128	ymm0, ymm2, XMMWORD PTR 16[r15+rdi*8], 0x1	# tmp182, tmp212, MEM <const vector(2) double> [(const double *)vectp.636_118 + 16B]
	vcvtpd2ps	xmm0, ymm0	# vect__62.639, tmp182
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	vmovups	XMMWORD PTR [r12+rdx*4], xmm0	# MEM <vector(4) float> [(float *)vectp_array.641_130], vect__62.639
	mov	edx, esi	# niters_vector_mult_vf.633, niters.631
	and	edx, -4	# niters_vector_mult_vf.633,
	add	eax, edx	# tmp.634, niters_vector_mult_vf.633
	cmp	esi, edx	# niters.631, niters_vector_mult_vf.633
	je	.L483	#,
.L472:
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	movsx	rdi, eax	# _33, tmp.634
	lea	rdx, [rcx+rdi]	# tmp183,
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	vxorps	xmm3, xmm3, xmm3	# tmp214
	vcvtsd2ss	xmm0, xmm3, QWORD PTR [r15+rdx*8]	# tmp205, tmp214, *_11
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	lea	rsi, 0[0+rdi*4]	# _13,
# stencil_template_parallel.c:1024:       for (int i = 1; i <= size[0]; i++)
	lea	edx, 1[rax]	# i,
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	vmovss	DWORD PTR -4[r12+rsi], xmm0	# *_15, tmp186
# stencil_template_parallel.c:1024:       for (int i = 1; i <= size[0]; i++)
	cmp	r14d, edx	# pretmp_63, i
	jb	.L483	#,
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	movsx	rdx, edx	# i, i
	add	rdx, rcx	# tmp188, _8
# stencil_template_parallel.c:1024:       for (int i = 1; i <= size[0]; i++)
	add	eax, 2	# i,
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	vcvtsd2ss	xmm0, xmm3, QWORD PTR [r15+rdx*8]	# tmp206, tmp215, *_66
	vmovss	DWORD PTR [r12+rdi*4], xmm0	# *_59, tmp190
# stencil_template_parallel.c:1024:       for (int i = 1; i <= size[0]; i++)
	cmp	r14d, eax	# pretmp_63, i
	jb	.L483	#,
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	cdqe
	add	rax, rcx	# tmp192, _8
# stencil_template_parallel.c:1027:         array[i - 1] = (float)line[i];
	vcvtsd2ss	xmm0, xmm3, QWORD PTR [r15+rax*8]	# tmp207, tmp216, *_99
	vmovss	DWORD PTR 4[r12+rsi], xmm0	# *_103, tmp195
	vzeroupper
.L470:
# stencil_template_parallel.c:1030:       fwrite(array, sizeof(float), size[0], outfile);
	mov	rcx, r13	#, outfile
	mov	rdx, r9	#, pretmp_63
	mov	esi, 4	#,
	mov	rdi, r12	#, array
	mov	DWORD PTR 24[rsp], r8d	# %sfp, j
	call	fwrite@PLT	#
# stencil_template_parallel.c:1021:     for (int j = 1; j <= size[1]; j++)
	mov	r8d, DWORD PTR 24[rsp]	# j, %sfp
	inc	r8d	# j
# stencil_template_parallel.c:1021:     for (int j = 1; j <= size[1]; j++)
	cmp	DWORD PTR 4[rbx], r8d	# MEM[(const uint *)size_30(D) + 4B], j
	jb	.L464	#,
# stencil_template_parallel.c:1023:       const double *restrict line = data + j * (size[0] + 2);
	mov	r9d, DWORD PTR [rbx]	#, *size_30(D)
	mov	r14, r9	#,
	jmp	.L474	#
	.p2align 4,,10
	.p2align 3
.L483:
	vzeroupper
	jmp	.L470	#
	.p2align 4,,10
	.p2align 3
.L485:
	.cfi_def_cfa 7, 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
# stencil_template_parallel.c:1040: }
	ret	
	.p2align 4,,10
	.p2align 3
.L464:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -56
	.cfi_offset 6, -16
	.cfi_offset 12, -48
	.cfi_offset 13, -40
	.cfi_offset 14, -32
	.cfi_offset 15, -24
# stencil_template_parallel.c:1033:     free(array);
	mov	rdi, r12	#, array
	call	free@PLT	#
# stencil_template_parallel.c:1035:     fclose(outfile);
	mov	rdi, r13	#, outfile
	call	fclose@PLT	#
# stencil_template_parallel.c:1040: }
	lea	rsp, -40[rbp]	#,
	pop	rbx	#
	pop	r12	#
	pop	r13	#
	pop	r14	#
	pop	r15	#
# stencil_template_parallel.c:1036:     return 0;
	xor	eax, eax	# <retval>
# stencil_template_parallel.c:1040: }
	pop	rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
.L478:
	.cfi_restore_state
# stencil_template_parallel.c:1024:       for (int i = 1; i <= size[0]; i++)
	xor	edx, edx	#
# stencil_template_parallel.c:1024:       for (int i = 1; i <= size[0]; i++)
	mov	eax, 1	# tmp.634,
	jmp	.L467	#
.L477:
# stencil_template_parallel.c:1017:       return 2;
	mov	eax, 2	# <retval>,
	jmp	.L462	#
	.cfi_endproc
.LFE79:
	.size	dump, .-dump
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1070596096
	.align 8
.LC1:
	.long	0
	.long	1071644672
	.align 8
.LC3:
	.long	0
	.long	1069547520
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC5:
	.long	1
	.section	.rodata.cst8
	.align 8
.LC14:
	.long	0
	.long	1072693248
	.section	.rodata.cst4
	.align 4
.LC27:
	.long	-2
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
