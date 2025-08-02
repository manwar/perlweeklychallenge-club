#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
276-2   Maximum Frequency       Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.  Write a script to
return the total number of elements in the given array which have the
highest frequency.

Example 1
Input: @ints = (1, 2, 2, 4, 1, 5)
Ouput: 4

The maximum frequency is 2.
The elements 1 and 2 has the maximum frequency.
Example 2
Input: @ints = (1, 2, 3, 4, 5)
Ouput: 5

The maximum frequency is 1.
The elements 1, 2, 3, 4 and 5 has the maximum frequency.

=end comment

my @Test =
    # exp   in
    Int,    List,
    Int,    Array,
#   Int,    Seq,
    3,  (1…3),
    0,  (),
    0,  [],
    4,  (1, 2, 2, 4, 1, 5),
    5,  (1, 2, 3, 4, 5),
    10,  (1, 2, 3, 4, 5, 6, 2, 3, 4, 5, 6),
;

plan @Test ÷ 2;

constant \MAX-RET-LIST = $*RAKU.compiler.version.Str ge "2023.08";

#multi task( @a where { ! .defined and .isa( Seq) } ) { Int }
multi task( @a where { ! .defined and .isa( List)} ) { Int }
multi task( @a) {

    if not MAX-RET-LIST { return sum @a.Bag.max( :v); }

    my @v =@a.Bag.values».Int;
    return sum grep ( * == @v.max ), @v;
}

for @Test -> $exp, @in {
    is task(@in), $exp, !$exp.defined ?? '(Int)' !! " $exp  <- @in.raku()";
}

done-testing;

my @int = 1, 2, 3, 4, 2, 3, 4, 3, 4, 3, 4, 5;
say "\nInput: @ints = @int.raku()\nOutput: ", task( @int);

