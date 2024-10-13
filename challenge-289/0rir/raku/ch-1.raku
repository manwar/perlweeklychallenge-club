#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT die 'Rakudo version is too old; need max with named args.'
     unless $*RAKU.compiler.version cmp v2023.07 == More;
use Test;

=begin comment
289-1: Third Maximum        Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.
Write a script to find the third distinct maximum in the given array.
If third maximum doesn’t exist then return the maximum number.

Example 1
Input: @ints = (5, 6, 4, 1)
Output: 4

The first distinct maximum is 6.
The second distinct maximum is 5.
The third distinct maximum is 4.
Example 2
Input: @ints = (4, 5)
Output: 5

In the given array, the third maximum doesn't exist therefore returns the
maximum.

Example 3
Input: @ints =  (1, 2, 2, 3)
Output: 1

The first distinct maximum is 3.
The second distinct maximum is 2.
The third distinct maximum is 1.

=end comment

my @Test =
    (),                 Int,
    (1,),               1,
    (1, 1),             1,
    (1, 1, 1),          1,
    (1, 1, 1, 1),       1,
    (1, 2, 1, -1),     -1,
    (1, 2, 2, 1),       2,
    (1, 2, 2, 3),       1,
    (4, 5),             5,
    (5, 6, 4, 1),       4,
    (1, 2, 2, 3, 3),    1,
;
plan @Test ÷ 2;

multi task( () ) {Int}
multi task( $in) {
    my Int @a = |$in;
    my $max  = @a.max;
    for ^2 {
        @a[ @a.max( :k) ]:delete;
        return $max if @a ~~ [];
    }
    @a.max;
}

for @Test -> @in, $exp {
    is task(@in), $exp, "$exp.Int.raku() <- @in.raku()";
}

done-testing;

my @int = 1,2,2,2,2;
say "\nInput: @ints = { @int.raku }\n Output: { task @int }";
