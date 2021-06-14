#!/usr/bin/env raku
use v6;
use MONKEY-TYPING;

augment class Int {
   method is-square (--> Bool:D) { self == self.sqrt.Int ** 2 }
}

sub sum-of-squares (Int $N where * >= 10 --> Int:D) {
   $N.comb.map(* ** 2).sum.is-square ?? 1 !! 0;
}

sub MAIN (*@inputs) {
   @inputs = < 34 50 52 > unless @inputs.elems;
   sum-of-squares($_).put for @inputs;
}
