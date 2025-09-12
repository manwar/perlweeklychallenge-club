#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use Test;

=begin comment
# Edited for space.
337-1: Smaller Than Current        Submitted by: Mohammad Sajid Anwar
You are given an array of numbers, @num1.

Write a script to return an array, @num2, where $num2[i] is the count of all numbers less than or equal to $num1[i].

Example 1
Input: @num1 = (6, 5, 4, 8)
Output: (2, 1, 0, 3)

index 0: numbers <= 6 are 5, 4    => 2
index 1: numbers <= 5 are 4       => 1
index 2: numbers <= 4, none       => 0
index 3: numbers <= 8 are 6, 5, 4 => 3

Example 2
Input: @num1 = (7, 7, 7, 7)
Output: (3, 3, 3, 3)

Example 3
Input: @num1 = (5, 4, 3, 2, 1)
Output: (4, 3, 2, 1, 0)

Example 4
Input: @num1 = (-1, 0, 3, -2, 1)
Output: (1, 2, 4, 0, 3)

Example 5
Input: @num1 = (0, 1, 1, 2, 0)
Output: (1, 3, 3, 4, 1)

=end comment

my @Test =
    # @in                @exp
    (6, 5, 4, 8),       (2, 1, 0, 3),
    (7, 7, 7, 7),       (3, 3, 3, 3),
    (5, 4, 3, 2, 1),    (4, 3, 2, 1, 0),
    (-1, 0, 3, -2, 1),  (1, 2, 4, 0, 3),
    (0, 1, 1, 2, 0),    (1, 3, 3, 4, 1),
    (),                 (),
    (1,),               (0,),
;
plan +@Test ÷ 2;

multi task( () ) { () }
multi task( @a) {
    @a.map( { my \i = $_;  @a.grep( * <= i ) - 1})
}

for @Test -> @in, @exp {
    is task( @in), @exp, "{@exp // @exp.^name()} <- @in.raku()";
}
done-testing;

my @num = -1, 0, 3, -2, 1, 5, -2, 10, 10;

say qq{\nInput: @num = ({@num.join(', ')})\nOutput: }, task @num;
