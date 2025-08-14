#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
334-2: Nearest Valid Point  Submitted by: Mohammad Sajid Anwar
You are given current location as two integers: x and y. You are also given a list of points on the grid.

A point is considered valid if it shares either the same x-coordinate or the same y-coordinate as the current location.

Write a script to return the index of the valid point that has the smallest Manhattan distance to the current location. If multiple valid points are tied for the smallest distance, return the one with the lowest index. If no valid points exist, return -1.


The Manhattan distance between two points (x1, y1) and (x2, y2) is calculated as: |x1 - x2| + |y1 - y2|

Example 1
Input: $x = 3, $y = 4, @points ([1, 2], [3, 1], [2, 4], [2, 3])
Output: 2

Valid points: [3, 1] (same x), [2, 4] (same y)

Manhattan distances:
    [3, 1] => |3-3| + |4-1| = 3
    [2, 4] => |3-2| + |4-4| = 1

Closest valid point is [2, 4] at index 2.

Example 2
Input: $x = 2, $y = 5, @points ([3, 4], [2, 3], [1, 5], [2, 5])
Output: 3

Valid points: [2, 3], [1, 5], [2, 5]

Example 3
Input: $x = 1, $y = 1, @points ([2, 2], [3, 3], [4, 4])
Output: -1

Example 4
Input: $x = 0, $y = 0, @points ([0, 1], [1, 0], [0, 2], [2, 0])
Output: 0

Example 5
Input: $x = 5, $y = 5, @points ([5, 6], [6, 5], [5, 4], [4, 5])
Output: 0

=end comment

my @Test =
 # $x  $y          @point                       $exp
    3,  4,  ([1, 2], [3, 1], [2, 4], [2, 3]),   2,
    2,  5,  ([3, 4], [2, 3], [1, 5], [2, 5]),   3,
    1,  1,  ([2, 2], [3, 3], [4, 4]),          -1,
    0,  0,  ([0, 1], [1, 0], [0, 2], [2, 0]),   0,
    5,  5,  ([5, 6], [6, 5], [5, 4], [4, 5]),   0,
    2,  5,  (),                                -1,
    2,  5,  ([1,1],),                          -1,
;
plan +@Test ÷ 4;

sub valid( \x, \y, @xy -->Bool) { so (x,y).any == @xy.any }

sub manhattan( \x, \y, @xy -->Int) { (x - @xy[0]).abs + ( y - @xy[1]).abs }

sub task( \x, \y, @point, Int :$OOB-FOR-NONE = -1 -->Int:D) {
    my @valid = @point.grep: :p, { valid( x, y, $_)};

    @valid.=map: { .key => manhattan x, y, .value };

   my \k = @valid.first( :k, { .value ~~ once $ = min @valid».value; })
           // return $OOB-FOR-NONE;
   @valid[k].key
}

for @Test -> $x, $y, @point, $exp {
    is task( $x, $y, @point), $exp,
        "{$exp // $exp.^name()} <- @point.raku() x $x y $y";
}
done-testing;

my $x = 15;
my $y =  5;
my @a =  ([5, 6], [15, 5], [5, 4], [4, 15], [1,1]);

say qq{\nInput: \$x = $x, \$y = $y, @points @a.raku()\nOutput: },task $x,$y,@a;

