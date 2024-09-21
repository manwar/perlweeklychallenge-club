#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
Put a different way, go through an array halving its size by taking,
starting at index 0, two elements and replacing them with their min.
The next two elements are replaced by their max. Continue through the
array, alternating min and max.  Repeat this on each derived array until
there is one element which is the solution.


286-2: Order Game
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, whose length is a power of 2.

Write a script to play the order game (min and max) and return the last element.

Example 1
Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2)
Output: 1

Operation 1:

    min(2, 1) = 1
    max(4, 5) = 5
    min(6, 3) = 3
    max(0, 2) = 2

Operation 2:

    min(1, 5) = 1
    max(3, 2) = 3

Operation 3:

    min(1, 3) = 1
Example 2
Input: @ints = (0, 5, 3, 2)
Output: 0

Operation 1:

    min(0, 5) = 0
    max(3, 2) = 3

Operation 2:

    min(0, 3) = 0
Example 3
Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
Output: 2

Operation 1:

    min(9, 2) = 2
    max(1, 4) = 4
    min(5, 6) = 5
    max(0, 7) = 7
    min(3, 1) = 1
    max(3, 5) = 5
    min(7, 9) = 7
    max(0, 8) = 8

Operation 2:

    min(2, 4) = 2
    max(5, 7) = 7
    min(1, 5) = 1
    max(7, 8) = 8

Operation 3:

    min(2, 7) = 2
    max(1, 8) = 8

Operation 4:

    min(2, 8) = 2

=end comment

constant @gtr-power-of-two = lazy 4, (* × 2) …  2**10;

my @Test =
    (2, 1, 4, 5, 6, 3, 0, 2),                           1,
    (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8),   2,
    (2, 2, 1, 2, 2, 2, 2, 1),                           2,
    (1,2),                                              1,
    (2,1),                                              1,
    (2,2),                                              2,
    (5,),                                               5,
    (),                                                 Int,
    (0, 5, 3, 2),                                       0,
;

plan @Test ÷ 2;


sub prefix:<≭>( Bool $a is rw ) { $a = !$a }    # U-226D 'not equiv to'

multi task( @a where *.elems ≤ 2) { @a.elems == 0 ?? Int !! @a.min }
multi task( @a ) {
    my Bool $f;
    my @b = @a.rotor(2).map({ ≭$f ?? $_.min !! $_.max }).Array;
    task( @b.Array);
}

for @Test -> $in, $exp {
    is task($in), $exp, $exp // "Int" ~ " <- "  ~ $in.raku;
}

done-testing;

my @int = (2, 2, 1, 2, 2, 2, 2, 1);
say "\nInput: @int = @int[]\nOutput: { task @int }";
