#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
293-2: Boomerang            Submitted by: Mohammad Sajid Anwar
You are given an array of points, (x, y).

Write a script to find out if the given points are a boomerang.

A boomerang is a set of three points that are all distinct and not in a straight line.

Example 1
Input: @points = ( [1, 1], [2, 3], [3,2] )
Output: true
Example 2
Input: @points = ( [1, 1], [2, 2], [3, 3] )
Output: false
Example 3
Input: @points = ( [1, 1], [1, 2], [2, 3] )
Output: true
Example 4
Input: @points = ( [1, 1], [1, 2], [1, 3] )
Output: false
Example 5
Input: @points = ( [1, 1], [2, 1], [3, 1] )
Output: false
Example 6
Input: @points = ( [0, 0], [2, 3], [4, 5] )
Output: true

=end comment

my @Test =
   ( [1, 10], [6, 60], [3,30] ),    False,
   ( [1, 1], [2, 3], [3,2] ),       True,
   ( [1, 1], [2, 2], [3, 3] ),      False,
   ( [1, 1], [2, 1], [3, 1] ),      False,
   ( [0, 0], [2, 3], [4, 5] ),      True,
   ( [0,-1], [0, 0], [0,1] ),       False,
   ( [0, 0], [0,1], [0,-1] ),       True,
   ( [1, 1], [1, 2], [2, 3] ),      True,
;

plan @Test ÷ 2;

enum dim < X Y >;

multi slope( @a where +* == 2 ) {  slope @a[0], @a[1] }
multi slope( $a, $b ) { ($b[Y] - $a[Y]) / ( $b[X] - $a[X]); }

sub task( @a where 3==* -->Bool) {
    slope( @a[0..1]) != slope( @a[1..2]);
}

for @Test -> @in, $exp {
    is task(@in), $exp, "$exp <- @in.raku()";
}

done-testing;

my @point =  [ -0.5, -0.5], [0, -0.375], [0.5, -.25];
say "\nInput: @points = @point[]\nOutput: { task @point}";

