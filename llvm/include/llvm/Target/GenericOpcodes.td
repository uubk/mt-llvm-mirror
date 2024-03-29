//===-- GenericOpcodes.td - Opcodes used with GlobalISel ---*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the generic opcodes used with GlobalISel.
// After instruction selection, these opcodes should not appear.
//
//===----------------------------------------------------------------------===//

//------------------------------------------------------------------------------
// Unary ops.
//------------------------------------------------------------------------------

class GenericInstruction : StandardPseudoInstruction;

// Extend the underlying scalar type of an operation, leaving the high bits
// unspecified.
def G_ANYEXT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

// Sign extend the underlying scalar type of an operation, copying the sign bit
// into the newly-created space.
def G_SEXT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

// Sign extend the a value from an arbitrary bit position, copying the sign bit
// into all bits above it. This is equivalent to a shl + ashr pair with an
// appropriate shift amount. $sz is an immediate (MachineOperand::isImm()
// returns true) to allow targets to have some bitwidths legal and others
// lowered. This opcode is particularly useful if the target has sign-extension
// instructions that are cheaper than the constituent shifts as the optimizer is
// able to make decisions on whether it's better to hang on to the G_SEXT_INREG
// or to lower it and optimize the individual shifts.
def G_SEXT_INREG : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src, untyped_imm_0:$sz);
  let hasSideEffects = 0;
}

// Zero extend the underlying scalar type of an operation, putting zero bits
// into the newly-created space.
def G_ZEXT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}


// Truncate the underlying scalar type of an operation. This is equivalent to
// G_EXTRACT for scalar types, but acts elementwise on vectors.
def G_TRUNC : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_IMPLICIT_DEF : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins);
  let hasSideEffects = 0;
}

def G_PHI : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins variable_ops);
  let hasSideEffects = 0;
}

def G_FRAME_INDEX : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins unknown:$src2);
  let hasSideEffects = 0;
}

def G_GLOBAL_VALUE : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins unknown:$src);
  let hasSideEffects = 0;
}

def G_INTTOPTR : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_PTRTOINT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_BITCAST : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

// Only supports scalar result types
def G_CONSTANT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins unknown:$imm);
  let hasSideEffects = 0;
}

// Only supports scalar result types
def G_FCONSTANT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins unknown:$imm);
  let hasSideEffects = 0;
}

def G_VASTART : GenericInstruction {
  let OutOperandList = (outs);
  let InOperandList = (ins type0:$list);
  let hasSideEffects = 0;
  let mayStore = 1;
}

def G_VAARG : GenericInstruction {
  let OutOperandList = (outs type0:$val);
  let InOperandList = (ins type1:$list, unknown:$align);
  let hasSideEffects = 0;
  let mayLoad = 1;
  let mayStore = 1;
}

def G_CTLZ : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_CTLZ_ZERO_UNDEF : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_CTTZ : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_CTTZ_ZERO_UNDEF : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_CTPOP : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_BSWAP : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src);
  let hasSideEffects = 0;
}

def G_BITREVERSE : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src);
  let hasSideEffects = 0;
}

def G_ADDRSPACE_CAST : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_BLOCK_ADDR : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins unknown:$ba);
  let hasSideEffects = 0;
}

def G_JUMP_TABLE : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins unknown:$jti);
  let hasSideEffects = 0;
}

def G_DYN_STACKALLOC : GenericInstruction {
  let OutOperandList = (outs ptype0:$dst);
  let InOperandList = (ins type1:$size, i32imm:$align);
  let hasSideEffects = 1;
}

//------------------------------------------------------------------------------
// Binary ops.
//------------------------------------------------------------------------------

// Generic addition.
def G_ADD : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic subtraction.
def G_SUB : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 0;
}

// Generic multiplication.
def G_MUL : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic signed division.
def G_SDIV : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 0;
}

// Generic unsigned division.
def G_UDIV : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 0;
}

// Generic signed remainder.
def G_SREM : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 0;
}

// Generic unsigned remainder.
def G_UREM : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 0;
}

// Generic bitwise and.
def G_AND : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic bitwise or.
def G_OR : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic bitwise xor.
def G_XOR : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic left-shift.
def G_SHL : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type1:$src2);
  let hasSideEffects = 0;
}

// Generic logical right-shift.
def G_LSHR : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type1:$src2);
  let hasSideEffects = 0;
}

// Generic arithmetic right-shift.
def G_ASHR : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type1:$src2);
  let hasSideEffects = 0;
}

// Generic integer comparison.
def G_ICMP : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins unknown:$tst, type1:$src1, type1:$src2);
  let hasSideEffects = 0;
}

// Generic floating-point comparison.
def G_FCMP : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins unknown:$tst, type1:$src1, type1:$src2);
  let hasSideEffects = 0;
}

// Generic select
def G_SELECT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$tst, type0:$src1, type0:$src2);
  let hasSideEffects = 0;
}

// Generic pointer offset.
def G_GEP : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type1:$src2);
  let hasSideEffects = 0;
}

def G_PTR_MASK : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src, unknown:$bits);
  let hasSideEffects = 0;
}

// Generic signed integer minimum.
def G_SMIN : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic signed integer maximum.
def G_SMAX : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic unsigned integer minimum.
def G_UMIN : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic unsigned integer maximum.
def G_UMAX : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

//------------------------------------------------------------------------------
// Overflow ops
//------------------------------------------------------------------------------

// Generic unsigned addition producing a carry flag.
def G_UADDO : GenericInstruction {
  let OutOperandList = (outs type0:$dst, type1:$carry_out);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic unsigned addition consuming and producing a carry flag.
def G_UADDE : GenericInstruction {
  let OutOperandList = (outs type0:$dst, type1:$carry_out);
  let InOperandList = (ins type0:$src1, type0:$src2, type1:$carry_in);
  let hasSideEffects = 0;
}

// Generic signed addition producing a carry flag.
def G_SADDO : GenericInstruction {
  let OutOperandList = (outs type0:$dst, type1:$carry_out);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic signed addition consuming and producing a carry flag.
def G_SADDE : GenericInstruction {
  let OutOperandList = (outs type0:$dst, type1:$carry_out);
  let InOperandList = (ins type0:$src1, type0:$src2, type1:$carry_in);
  let hasSideEffects = 0;
}

// Generic unsigned subtraction producing a carry flag.
def G_USUBO : GenericInstruction {
  let OutOperandList = (outs type0:$dst, type1:$carry_out);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
}
// Generic unsigned subtraction consuming and producing a carry flag.
def G_USUBE : GenericInstruction {
  let OutOperandList = (outs type0:$dst, type1:$carry_out);
  let InOperandList = (ins type0:$src1, type0:$src2, type1:$carry_in);
  let hasSideEffects = 0;
}

// Generic signed subtraction producing a carry flag.
def G_SSUBO : GenericInstruction {
  let OutOperandList = (outs type0:$dst, type1:$carry_out);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
}

// Generic signed subtraction consuming and producing a carry flag.
def G_SSUBE : GenericInstruction {
  let OutOperandList = (outs type0:$dst, type1:$carry_out);
  let InOperandList = (ins type0:$src1, type0:$src2, type1:$carry_in);
  let hasSideEffects = 0;
}

// Generic unsigned multiplication producing a carry flag.
def G_UMULO : GenericInstruction {
  let OutOperandList = (outs type0:$dst, type1:$carry_out);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic signed multiplication producing a carry flag.
def G_SMULO : GenericInstruction {
  let OutOperandList = (outs type0:$dst, type1:$carry_out);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Multiply two numbers at twice the incoming bit width (unsigned) and return
// the high half of the result.
def G_UMULH : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Multiply two numbers at twice the incoming bit width (signed) and return
// the high half of the result.
def G_SMULH : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

//------------------------------------------------------------------------------
// Floating Point Unary Ops.
//------------------------------------------------------------------------------

def G_FNEG : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src);
  let hasSideEffects = 0;
}

def G_FPEXT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_FPTRUNC : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_FPTOSI : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_FPTOUI : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_SITOFP : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_UITOFP : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

def G_FABS : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src);
  let hasSideEffects = 0;
}

def G_FCOPYSIGN : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src0, type1:$src1);
  let hasSideEffects = 0;
}

def G_FCANONICALIZE : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src);
  let hasSideEffects = 0;
}

// FMINNUM/FMAXNUM - Perform floating-point minimum or maximum on two
// values.
//
// In the case where a single input is a NaN (either signaling or quiet),
// the non-NaN input is returned.
//
// The return value of (FMINNUM 0.0, -0.0) could be either 0.0 or -0.0.
def G_FMINNUM : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

def G_FMAXNUM : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// FMINNUM_IEEE/FMAXNUM_IEEE - Perform floating-point minimum or maximum on
// two values, following the IEEE-754 2008 definition. This differs from
// FMINNUM/FMAXNUM in the handling of signaling NaNs. If one input is a
// signaling NaN, returns a quiet NaN.
def G_FMINNUM_IEEE : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

def G_FMAXNUM_IEEE : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// FMINIMUM/FMAXIMUM - NaN-propagating minimum/maximum that also treat -0.0
// as less than 0.0. While FMINNUM_IEEE/FMAXNUM_IEEE follow IEEE 754-2008
// semantics, FMINIMUM/FMAXIMUM follow IEEE 754-2018 draft semantics.
def G_FMINIMUM : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

def G_FMAXIMUM : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

//------------------------------------------------------------------------------
// Floating Point Binary ops.
//------------------------------------------------------------------------------

// Generic FP addition.
def G_FADD : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic FP subtraction.
def G_FSUB : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 0;
}

// Generic FP multiplication.
def G_FMUL : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
  let isCommutable = 1;
}

// Generic fused multiply-add instruction.
// Behaves like llvm fma intrinsic ie src1 * src2 + src3
def G_FMA : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2, type0:$src3);
  let hasSideEffects = 0;
  let isCommutable = 0;
}

// Generic FP division.
def G_FDIV : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
}

// Generic FP remainder.
def G_FREM : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
}

// Floating point exponentiation.
def G_FPOW : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1, type0:$src2);
  let hasSideEffects = 0;
}

// Floating point base-e exponential of a value.
def G_FEXP : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point base-2 exponential of a value.
def G_FEXP2 : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point base-2 logarithm of a value.
def G_FLOG : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point base-2 logarithm of a value.
def G_FLOG2 : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point base-10 logarithm of a value.
def G_FLOG10 : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point ceiling of a value.
def G_FCEIL : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point cosine of a value.
def G_FCOS : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point sine of a value.
def G_FSIN : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point square root of a value.
// This returns NaN for negative nonzero values.
// NOTE: Unlike libm sqrt(), this never sets errno. In all other respects it's
// libm-conformant.
def G_FSQRT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point floor of a value.
def G_FFLOOR : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point round to next integer.
def G_FRINT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

// Floating point round to the nearest integer.
def G_FNEARBYINT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

//------------------------------------------------------------------------------
// Opcodes for LLVM Intrinsics
//------------------------------------------------------------------------------
def G_INTRINSIC_TRUNC : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

def G_INTRINSIC_ROUND : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
}

//------------------------------------------------------------------------------
// Memory ops
//------------------------------------------------------------------------------

// Generic load. Expects a MachineMemOperand in addition to explicit
// operands. If the result size is larger than the memory size, the
// high bits are undefined. If the result is a vector type and larger
// than the memory size, the high elements are undefined (i.e. this is
// not a per-element, vector anyextload)
def G_LOAD : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins ptype1:$addr);
  let hasSideEffects = 0;
  let mayLoad = 1;
}

// Generic sign-extended load. Expects a MachineMemOperand in addition to explicit operands.
def G_SEXTLOAD : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins ptype1:$addr);
  let hasSideEffects = 0;
  let mayLoad = 1;
}

// Generic zero-extended load. Expects a MachineMemOperand in addition to explicit operands.
def G_ZEXTLOAD : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins ptype1:$addr);
  let hasSideEffects = 0;
  let mayLoad = 1;
}

// Generic store. Expects a MachineMemOperand in addition to explicit operands.
def G_STORE : GenericInstruction {
  let OutOperandList = (outs);
  let InOperandList = (ins type0:$src, ptype1:$addr);
  let hasSideEffects = 0;
  let mayStore = 1;
}

// Generic atomic cmpxchg with internal success check. Expects a
// MachineMemOperand in addition to explicit operands.
def G_ATOMIC_CMPXCHG_WITH_SUCCESS : GenericInstruction {
  let OutOperandList = (outs type0:$oldval, type1:$success);
  let InOperandList = (ins type2:$addr, type0:$cmpval, type0:$newval);
  let hasSideEffects = 0;
  let mayLoad = 1;
  let mayStore = 1;
}

// Generic atomic cmpxchg. Expects a MachineMemOperand in addition to explicit
// operands.
def G_ATOMIC_CMPXCHG : GenericInstruction {
  let OutOperandList = (outs type0:$oldval);
  let InOperandList = (ins ptype1:$addr, type0:$cmpval, type0:$newval);
  let hasSideEffects = 0;
  let mayLoad = 1;
  let mayStore = 1;
}

// Generic atomicrmw. Expects a MachineMemOperand in addition to explicit
// operands.
class G_ATOMICRMW_OP : GenericInstruction {
  let OutOperandList = (outs type0:$oldval);
  let InOperandList = (ins ptype1:$addr, type0:$val);
  let hasSideEffects = 0;
  let mayLoad = 1;
  let mayStore = 1;
}

def G_ATOMICRMW_XCHG : G_ATOMICRMW_OP;
def G_ATOMICRMW_ADD : G_ATOMICRMW_OP;
def G_ATOMICRMW_SUB : G_ATOMICRMW_OP;
def G_ATOMICRMW_AND : G_ATOMICRMW_OP;
def G_ATOMICRMW_NAND : G_ATOMICRMW_OP;
def G_ATOMICRMW_OR : G_ATOMICRMW_OP;
def G_ATOMICRMW_XOR : G_ATOMICRMW_OP;
def G_ATOMICRMW_MAX : G_ATOMICRMW_OP;
def G_ATOMICRMW_MIN : G_ATOMICRMW_OP;
def G_ATOMICRMW_UMAX : G_ATOMICRMW_OP;
def G_ATOMICRMW_UMIN : G_ATOMICRMW_OP;
def G_ATOMICRMW_FADD : G_ATOMICRMW_OP;
def G_ATOMICRMW_FSUB : G_ATOMICRMW_OP;

def G_FENCE : GenericInstruction {
  let OutOperandList = (outs);
  let InOperandList = (ins i32imm:$ordering, i32imm:$scope);
  let hasSideEffects = 1;
}

//------------------------------------------------------------------------------
// Variadic ops
//------------------------------------------------------------------------------

// Extract a register of the specified size, starting from the block given by
// index. This will almost certainly be mapped to sub-register COPYs after
// register banks have been selected.
def G_EXTRACT : GenericInstruction {
  let OutOperandList = (outs type0:$res);
  let InOperandList = (ins type1:$src, unknown:$offset);
  let hasSideEffects = 0;
}

// Extract multiple registers specified size, starting from blocks given by
// indexes. This will almost certainly be mapped to sub-register COPYs after
// register banks have been selected.
// The output operands are always ordered from lowest bits to highest:
//   %bits_0_7:(s8), %bits_8_15:(s8),
//       %bits_16_23:(s8), %bits_24_31:(s8) = G_UNMERGE_VALUES %0:(s32)
def G_UNMERGE_VALUES : GenericInstruction {
  let OutOperandList = (outs type0:$dst0, variable_ops);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = 0;
}

// Insert a smaller register into a larger one at the specified bit-index.
def G_INSERT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src, type1:$op, unknown:$offset);
  let hasSideEffects = 0;
}

// Concatenate multiple registers of the same size into a wider register.
// The input operands are always ordered from lowest bits to highest:
//   %0:(s32) = G_MERGE_VALUES %bits_0_7:(s8), %bits_8_15:(s8),
//                             %bits_16_23:(s8), %bits_24_31:(s8)
def G_MERGE_VALUES : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src0, variable_ops);
  let hasSideEffects = 0;
}

/// Create a vector from multiple scalar registers. No implicit
/// conversion is performed (i.e. the result element type must be the
/// same as all source operands)
def G_BUILD_VECTOR : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src0, variable_ops);
  let hasSideEffects = 0;
}

/// Like G_BUILD_VECTOR, but truncates the larger operand types to fit the
/// destination vector elt type.
def G_BUILD_VECTOR_TRUNC : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src0, variable_ops);
  let hasSideEffects = 0;
}

/// Create a vector by concatenating vectors together.
def G_CONCAT_VECTORS : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src0, variable_ops);
  let hasSideEffects = 0;
}

// Intrinsic without side effects.
def G_INTRINSIC : GenericInstruction {
  let OutOperandList = (outs);
  let InOperandList = (ins unknown:$intrin, variable_ops);
  let hasSideEffects = 0;
}

// Intrinsic with side effects.
def G_INTRINSIC_W_SIDE_EFFECTS : GenericInstruction {
  let OutOperandList = (outs);
  let InOperandList = (ins unknown:$intrin, variable_ops);
  let hasSideEffects = 1;
  let mayLoad = 1;
  let mayStore = 1;
}

//------------------------------------------------------------------------------
// Branches.
//------------------------------------------------------------------------------

// Generic unconditional branch.
def G_BR : GenericInstruction {
  let OutOperandList = (outs);
  let InOperandList = (ins unknown:$src1);
  let hasSideEffects = 0;
  let isBranch = 1;
  let isTerminator = 1;
  let isBarrier = 1;
}

// Generic conditional branch.
def G_BRCOND : GenericInstruction {
  let OutOperandList = (outs);
  let InOperandList = (ins type0:$tst, unknown:$truebb);
  let hasSideEffects = 0;
  let isBranch = 1;
  let isTerminator = 1;
}

// Generic indirect branch.
def G_BRINDIRECT : GenericInstruction {
  let OutOperandList = (outs);
  let InOperandList = (ins type0:$src1);
  let hasSideEffects = 0;
  let isBranch = 1;
  let isTerminator = 1;
}

// Generic branch to jump table entry
def G_BRJT : GenericInstruction {
  let OutOperandList = (outs);
  let InOperandList = (ins ptype0:$tbl, unknown:$jti, type1:$idx);
  let hasSideEffects = 0;
  let isBranch = 1;
  let isTerminator = 1;
}

//------------------------------------------------------------------------------
// Vector ops
//------------------------------------------------------------------------------

// Generic insertelement.
def G_INSERT_VECTOR_ELT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$src, type1:$elt, type2:$idx);
  let hasSideEffects = 0;
}

// Generic extractelement.
def G_EXTRACT_VECTOR_ELT : GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src, type2:$idx);
  let hasSideEffects = 0;
}

// Generic shufflevector.
//
// The mask operand should be an IR Constant which exactly matches the
// corresponding mask for the IR shufflevector instruction.
def G_SHUFFLE_VECTOR: GenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$v1, type1:$v2, unknown:$mask);
  let hasSideEffects = 0;
}

// TODO: Add the other generic opcodes.
