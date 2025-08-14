#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
334-Example 1
Task 1: Range Sum           Submitted by: Mohammad Sajid Anwar
You are given a list integers and pair of indices.
Write a script to return the sum of integers between the given indices (inclusive).

Input: @ints = (-2, 0, 3, -5, 2, -1), $x = 0, $y = 2
Output: 1

Elements between indices (0, 2) => (-2, 0, 3)
Range Sum: (-2) + 0 + 3 => 1

Example 2
Input: @ints = (1, -2, 3, -4, 5), $x = 1, $y = 3
Output: -3

Example 3
Input: @ints = (1, 0, 2, -1, 3), $x = 3, $y = 4
Output: 2

Example 4
Input: @ints = (-5, 4, -3, 2, -1, 0), $x = 0, $y = 3
Output: -2

Example 5
Input: @ints = (-1, 0, 2, -3, -2, 1), $x = 0, $y = 2
Output: 1

=end comment

my @Test =
    #       @a                 $i     $j   $exp
    (-2, 0, 3, -5, 2, -1),      0,     2,   1,
    (1, -2, 3, -4, 5),          1,     3,  -3,
    (1, 0, 2, -1, 3),           3,     4,   2,
    (-5, 4, -3, 2, -1, 0),      0,     3,  -2,
    (-1, 0, 2, -3, -2, 1),      0,     2,   1,
    (0,),                       0,     0,   0,
;
plan +@Test ÷ 4;

subset Pos of Int where * > -1;

sub task( @a, Pos:D $i, Pos:D $j where $i ≤ * < @a -->Int) {
    sum @a[$i..$j]
}

for @Test -> @a, $i, $j, $exp {
    is task( @a, $i, $j), $exp,
            "sum {$exp // $exp.^name()} <- @a.raku() [$i..$j]";
}
done-testing;

my @int = -1, 0, 2, 3, 7, -3, -2, 1;
my $x = 2;
my $y = 5;
say "\nInput: @int = (@int[]), \$x = $x, \$y = $y\n"
   ~"Output: &task( @int,$x,$y)";

