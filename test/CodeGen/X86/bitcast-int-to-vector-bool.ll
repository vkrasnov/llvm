; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=SSE2-SSSE3,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+ssse3 | FileCheck %s --check-prefixes=SSE2-SSSE3,SSSE3
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=AVX12,AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=AVX12,AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512vl,+avx512bw | FileCheck %s --check-prefixes=AVX512

define <2 x i1> @bitcast_i2_2i1(i2 zeroext %a0) {
; SSE2-SSSE3-LABEL: bitcast_i2_2i1:
; SSE2-SSSE3:       # BB#0:
; SSE2-SSSE3-NEXT:    # kill: %edi<def> %edi<kill> %rdi<def>
; SSE2-SSSE3-NEXT:    movq %rdi, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[0,1,0,1]
; SSE2-SSSE3-NEXT:    movdqa {{.*#+}} xmm0 = [1,2]
; SSE2-SSSE3-NEXT:    pand %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    pcmpeqd %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,0,3,2]
; SSE2-SSSE3-NEXT:    pand %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    psrlq $63, %xmm0
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: bitcast_i2_2i1:
; AVX1:       # BB#0:
; AVX1-NEXT:    # kill: %edi<def> %edi<kill> %rdi<def>
; AVX1-NEXT:    vmovq %rdi, %xmm0
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,1,0,1]
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm1 = [1,2]
; AVX1-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpcmpeqq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsrlq $63, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: bitcast_i2_2i1:
; AVX2:       # BB#0:
; AVX2-NEXT:    # kill: %edi<def> %edi<kill> %rdi<def>
; AVX2-NEXT:    vmovq %rdi, %xmm0
; AVX2-NEXT:    vpbroadcastq %xmm0, %xmm0
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm1 = [1,2]
; AVX2-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpcmpeqq %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpsrlq $63, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: bitcast_i2_2i1:
; AVX512:       # BB#0:
; AVX512-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movzbl -{{[0-9]+}}(%rsp), %eax
; AVX512-NEXT:    kmovd %eax, %k1
; AVX512-NEXT:    vpternlogq $255, %zmm0, %zmm0, %zmm0 {%k1} {z}
; AVX512-NEXT:    # kill: %xmm0<def> %xmm0<kill> %zmm0<kill>
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = bitcast i2 %a0 to <2 x i1>
  ret <2 x i1> %1
}

define <4 x i1> @bitcast_i4_4i1(i4 zeroext %a0) {
; SSE2-SSSE3-LABEL: bitcast_i4_4i1:
; SSE2-SSSE3:       # BB#0:
; SSE2-SSSE3-NEXT:    movd %edi, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; SSE2-SSSE3-NEXT:    movdqa {{.*#+}} xmm1 = [1,2,4,8]
; SSE2-SSSE3-NEXT:    pand %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    psrld $31, %xmm0
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: bitcast_i4_4i1:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovd %edi, %xmm0
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm1 = [1,2,4,8]
; AVX1-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpcmpeqd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsrld $31, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: bitcast_i4_4i1:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovd %edi, %xmm0
; AVX2-NEXT:    vpbroadcastd %xmm0, %xmm0
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm1 = [1,2,4,8]
; AVX2-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpcmpeqd %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpsrld $31, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: bitcast_i4_4i1:
; AVX512:       # BB#0:
; AVX512-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movzbl -{{[0-9]+}}(%rsp), %eax
; AVX512-NEXT:    kmovd %eax, %k1
; AVX512-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX512-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k1} {z}
; AVX512-NEXT:    # kill: %xmm0<def> %xmm0<kill> %ymm0<kill>
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = bitcast i4 %a0 to <4 x i1>
  ret <4 x i1> %1
}

define <8 x i1> @bitcast_i8_8i1(i8 zeroext %a0) {
; SSE2-SSSE3-LABEL: bitcast_i8_8i1:
; SSE2-SSSE3:       # BB#0:
; SSE2-SSSE3-NEXT:    movd %edi, %xmm0
; SSE2-SSSE3-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,0,0,0,4,5,6,7]
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,1,1]
; SSE2-SSSE3-NEXT:    movdqa {{.*#+}} xmm1 = [1,2,4,8,16,32,64,128]
; SSE2-SSSE3-NEXT:    pand %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    psrlw $15, %xmm0
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: bitcast_i8_8i1:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovd %edi, %xmm0
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[0,0,0,0,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,1,1]
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm1 = [1,2,4,8,16,32,64,128]
; AVX1-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpcmpeqw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsrlw $15, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: bitcast_i8_8i1:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovd %edi, %xmm0
; AVX2-NEXT:    vpbroadcastw %xmm0, %xmm0
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm1 = [1,2,4,8,16,32,64,128]
; AVX2-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpcmpeqw %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpsrlw $15, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: bitcast_i8_8i1:
; AVX512:       # BB#0:
; AVX512-NEXT:    kmovd %edi, %k0
; AVX512-NEXT:    vpmovm2w %k0, %xmm0
; AVX512-NEXT:    retq
  %1 = bitcast i8 %a0 to <8 x i1>
  ret <8 x i1> %1
}

define <16 x i1> @bitcast_i16_16i1(i16 zeroext %a0) {
; SSE2-LABEL: bitcast_i16_16i1:
; SSE2:       # BB#0:
; SSE2-NEXT:    movd %edi, %xmm0
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,0,1,1,4,5,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,1,1]
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [1,2,4,8,16,32,64,128,1,2,4,8,16,32,64,128]
; SSE2-NEXT:    pand %xmm1, %xmm0
; SSE2-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE2-NEXT:    psrlw $7, %xmm0
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm0
; SSE2-NEXT:    retq
;
; SSSE3-LABEL: bitcast_i16_16i1:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movd %edi, %xmm0
; SSSE3-NEXT:    pshufb {{.*#+}} xmm0 = xmm0[0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1]
; SSSE3-NEXT:    movdqa {{.*#+}} xmm1 = [1,2,4,8,16,32,64,128,1,2,4,8,16,32,64,128]
; SSSE3-NEXT:    pand %xmm1, %xmm0
; SSSE3-NEXT:    pcmpeqb %xmm1, %xmm0
; SSSE3-NEXT:    psrlw $7, %xmm0
; SSSE3-NEXT:    pand {{.*}}(%rip), %xmm0
; SSSE3-NEXT:    retq
;
; AVX1-LABEL: bitcast_i16_16i1:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovd %edi, %xmm0
; AVX1-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1]
; AVX1-NEXT:    vmovddup {{.*#+}} xmm1 = mem[0,0]
; AVX1-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpsrlw $7, %xmm0, %xmm0
; AVX1-NEXT:    vpand {{.*}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: bitcast_i16_16i1:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovd %edi, %xmm0
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1]
; AVX2-NEXT:    vpbroadcastq {{.*#+}} xmm1 = [9241421688590303745,9241421688590303745]
; AVX2-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpsrlw $7, %xmm0, %xmm0
; AVX2-NEXT:    vpand {{.*}}(%rip), %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: bitcast_i16_16i1:
; AVX512:       # BB#0:
; AVX512-NEXT:    kmovd %edi, %k0
; AVX512-NEXT:    vpmovm2b %k0, %xmm0
; AVX512-NEXT:    retq
  %1 = bitcast i16 %a0 to <16 x i1>
  ret <16 x i1> %1
}

define <32 x i1> @bitcast_i32_32i1(i32 %a0) {
; SSE2-SSSE3-LABEL: bitcast_i32_32i1:
; SSE2-SSSE3:       # BB#0:
; SSE2-SSSE3-NEXT:    movl %esi, (%rdi)
; SSE2-SSSE3-NEXT:    movq %rdi, %rax
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: bitcast_i32_32i1:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovd %edi, %xmm0
; AVX1-NEXT:    vpunpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm0[0,0,1,1,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[0,0,1,1]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[2,2,3,3,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,1,1]
; AVX1-NEXT:    vinsertf128 $1, %xmm0, %ymm1, %ymm0
; AVX1-NEXT:    vandps {{.*}}(%rip), %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; AVX1-NEXT:    vpcmpeqb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpcmpeqd %xmm3, %xmm3, %xmm3
; AVX1-NEXT:    vpxor %xmm3, %xmm1, %xmm1
; AVX1-NEXT:    vpsrlw $7, %xmm1, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm4 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
; AVX1-NEXT:    vpand %xmm4, %xmm1, %xmm1
; AVX1-NEXT:    vpcmpeqb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpxor %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vpsrlw $7, %xmm0, %xmm0
; AVX1-NEXT:    vpand %xmm4, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: bitcast_i32_32i1:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovd %edi, %xmm0
; AVX2-NEXT:    vpunpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; AVX2-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm0[0,0,1,1,4,5,6,7]
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[0,0,1,1]
; AVX2-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[2,2,3,3,4,5,6,7]
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,1,1]
; AVX2-NEXT:    vinserti128 $1, %xmm0, %ymm1, %ymm0
; AVX2-NEXT:    vpbroadcastq {{.*#+}} ymm1 = [9241421688590303745,9241421688590303745,9241421688590303745,9241421688590303745]
; AVX2-NEXT:    vpand %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpcmpeqb %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrlw $7, %ymm0, %ymm0
; AVX2-NEXT:    vpand {{.*}}(%rip), %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: bitcast_i32_32i1:
; AVX512:       # BB#0:
; AVX512-NEXT:    kmovd %edi, %k0
; AVX512-NEXT:    vpmovm2b %k0, %ymm0
; AVX512-NEXT:    retq
  %1 = bitcast i32 %a0 to <32 x i1>
  ret <32 x i1> %1
}

define <64 x i1> @bitcast_i64_64i1(i64 %a0) {
; SSE2-SSSE3-LABEL: bitcast_i64_64i1:
; SSE2-SSSE3:       # BB#0:
; SSE2-SSSE3-NEXT:    movq %rsi, (%rdi)
; SSE2-SSSE3-NEXT:    movq %rdi, %rax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: bitcast_i64_64i1:
; AVX12:       # BB#0:
; AVX12-NEXT:    movq %rsi, (%rdi)
; AVX12-NEXT:    movq %rdi, %rax
; AVX12-NEXT:    retq
;
; AVX512-LABEL: bitcast_i64_64i1:
; AVX512:       # BB#0:
; AVX512-NEXT:    kmovq %rdi, %k0
; AVX512-NEXT:    vpmovm2b %k0, %zmm0
; AVX512-NEXT:    retq
  %1 = bitcast i64 %a0 to <64 x i1>
  ret <64 x i1> %1
}
