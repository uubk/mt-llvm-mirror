; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefix=X86 --check-prefix=X86-NO-CMOV
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+cmov | FileCheck %s --check-prefix=X86 --check-prefix=X86-CMOV
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=X64

;; Integer absolute value, should produce something at least as good as:
;;       movl   %edi, %eax
;;       negl   %eax
;;       cmovll %edi, %eax
;;       ret
; rdar://10695237
define i8 @test_i8(i8 %a) nounwind {
; X86-LABEL: test_i8:
; X86:       # %bb.0:
; X86-NEXT:    movb {{[0-9]+}}(%esp), %al
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    sarb $7, %cl
; X86-NEXT:    addb %cl, %al
; X86-NEXT:    xorb %cl, %al
; X86-NEXT:    retl
;
; X64-LABEL: test_i8:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    sarb $7, %al
; X64-NEXT:    addb %al, %dil
; X64-NEXT:    xorb %al, %dil
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    retq
  %tmp1neg = sub i8 0, %a
  %b = icmp sgt i8 %a, -1
  %abs = select i1 %b, i8 %a, i8 %tmp1neg
  ret i8 %abs
}

define i16 @test_i16(i16 %a) nounwind {
; X86-NO-CMOV-LABEL: test_i16:
; X86-NO-CMOV:       # %bb.0:
; X86-NO-CMOV-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NO-CMOV-NEXT:    movl %eax, %ecx
; X86-NO-CMOV-NEXT:    sarw $15, %cx
; X86-NO-CMOV-NEXT:    addl %ecx, %eax
; X86-NO-CMOV-NEXT:    xorl %ecx, %eax
; X86-NO-CMOV-NEXT:    # kill: %ax<def> %ax<kill> %eax<kill>
; X86-NO-CMOV-NEXT:    retl
;
; X86-CMOV-LABEL: test_i16:
; X86-CMOV:       # %bb.0:
; X86-CMOV-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-CMOV-NEXT:    movl %ecx, %eax
; X86-CMOV-NEXT:    negw %ax
; X86-CMOV-NEXT:    cmovlw %cx, %ax
; X86-CMOV-NEXT:    retl
;
; X64-LABEL: test_i16:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    negw %ax
; X64-NEXT:    cmovlw %di, %ax
; X64-NEXT:    retq
  %tmp1neg = sub i16 0, %a
  %b = icmp sgt i16 %a, -1
  %abs = select i1 %b, i16 %a, i16 %tmp1neg
  ret i16 %abs
}

define i32 @test_i32(i32 %a) nounwind {
; X86-NO-CMOV-LABEL: test_i32:
; X86-NO-CMOV:       # %bb.0:
; X86-NO-CMOV-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NO-CMOV-NEXT:    movl %eax, %ecx
; X86-NO-CMOV-NEXT:    sarl $31, %ecx
; X86-NO-CMOV-NEXT:    addl %ecx, %eax
; X86-NO-CMOV-NEXT:    xorl %ecx, %eax
; X86-NO-CMOV-NEXT:    retl
;
; X86-CMOV-LABEL: test_i32:
; X86-CMOV:       # %bb.0:
; X86-CMOV-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-CMOV-NEXT:    movl %ecx, %eax
; X86-CMOV-NEXT:    negl %eax
; X86-CMOV-NEXT:    cmovll %ecx, %eax
; X86-CMOV-NEXT:    retl
;
; X64-LABEL: test_i32:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    negl %eax
; X64-NEXT:    cmovll %edi, %eax
; X64-NEXT:    retq
  %tmp1neg = sub i32 0, %a
  %b = icmp sgt i32 %a, -1
  %abs = select i1 %b, i32 %a, i32 %tmp1neg
  ret i32 %abs
}

define i64 @test_i64(i64 %a) nounwind {
; X86-LABEL: test_i64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %ecx
; X86-NEXT:    sarl $31, %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    adcl %ecx, %edx
; X86-NEXT:    xorl %ecx, %edx
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: test_i64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    negq %rax
; X64-NEXT:    cmovlq %rdi, %rax
; X64-NEXT:    retq
  %tmp1neg = sub i64 0, %a
  %b = icmp sgt i64 %a, -1
  %abs = select i1 %b, i64 %a, i64 %tmp1neg
  ret i64 %abs
}

