#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
294-2: Next Permutation         Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.
Write a script to find out the next permutation of the given array.

The next permutation of an array of integers is the next
lexicographically greater permutation of its integer.

Example 1
Input: @ints = (1, 2, 3)
Output: (1, 3, 2)

Permutations of (1, 2, 3) arranged lexicographically:
(1, 2, 3)
(1, 3, 2)
(2, 1, 3)
(2, 3, 1)
(3, 1, 2)
(3, 2, 1)
Example 2
Input: @ints = (2, 1, 3)
Output: (2, 3, 1)
Example 3
Input: @ints = (3, 1, 2)
Output: (3, 2, 1)

=end comment

my @Test =
    # in                exp, 
    [],                 [],
    [1],                [],
    [1,2],              [2,1],
    [2,1],              [],
    [1, 2, 3],          [1, 3, 2],
    [1, 3, 2],          [2, 1, 3],
    [2, 1, 3],          [2, 3, 1],
    [2, 3, 1],          [3, 1, 2],
    [3, 1, 2],          [3, 2, 1],
    [3, 2, 1],          [],
    [1, 1, 2, 3],       [1, 1, 3, 2],
    [1, 1, 3, 2],       [1, 2, 1, 3],
    [1, 2, 1, 3],       [1, 2, 3, 1],
    [1, 2, 3, 1],       [1, 3, 1, 2],
    [1, 3, 1, 2],       [1, 3, 2, 1] ,
    [1, 3, 2, 1],       [2, 1, 1, 3],
    [2, 1, 1, 3],       [2, 1, 3, 1],
    [2, 1, 3, 1],       [2, 3, 1, 1],
    [2, 3, 1, 1],       [3, 1, 1, 2],
    [2, 3, 1, 1],       [3, 1, 1, 2],
    [3, 1, 2, 1],       [3, 2, 1, 1],
    [3, 2, 1, 1],       [],
;
plan @Test ÷ 2 ;

only task( @in is copy -->Array) {

    my $ils;     # index of least significant out of order

    for +@in ^… 1 -> \i {
        if @in[i-1] < @in[i] { $ils = i;  last }
    }
    return [] without $ils;

    for +@in ^… $ils  -> \i {
        if @in[i] > @in[$ils - 1] {
            ( @in[$ils - 1], @in[i]) = @in[i], @in[$ils - 1];
            last;
        }
    }
    @in[$ils..*] = @in[$ils..*].reverse;
    @in;
}

for @Test -> @in, @exp {
    ok task(@in) ~~ @exp, "@exp.raku() <- @in.raku()";
}
done-testing;

my @int = 2, 1, 3;
say "\nInput: @ints = @int[]\nOutput: {task @int}";

