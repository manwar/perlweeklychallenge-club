#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an m x n binary matrix with 0 and 1 only.
Write a script to find the largest square containing only 1's and return it’s area.
Example 1
Input: @matrix = ([1, 0, 1, 0, 0],
                  [1, 0, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 0, 0, 1, 0])

Output: 4

Two maximal square found with same size marked as 'x':

[1, 0, 1, 0, 0]
[1, 0, x, x, 1]
[1, 1, x, x, 1]
[1, 0, 0, 1, 0]

[1, 0, 1, 0, 0]
[1, 0, 1, x, x]
[1, 1, 1, x, x]
[1, 0, 0, 1, 0]

Example 2
Input: @matrix = ([0, 1],
                  [1, 0])
Output: 1

Two maximal square found with same size marked as 'x':

[0, x]
[1, 0]


[0, 1]
[x, 0]

Example 3
Input: @matrix = ([0])
Output: 0
=cut

use List::Util qw(min max);
use Test2::V0 -no_srand => 1;

is(max_square([1, 0, 1, 0, 0],
          [1, 0, 1, 1, 1],
          [1, 1, 1, 1, 1],
          [1, 0, 0, 1, 0]), 4, 'Example 1');          
is(max_square([0, 1],
                  [1, 0]), 1, 'Example 2');
is(max_square([0]), 0, 'Example 3');
done_testing();

sub max_square 
{
     my $mtr = \@_;
     my $max_side = 0;
     my @prev_row = (0) x @{$mtr->[0]};
     my @curr_row = (0) x @{$mtr->[0]};

     for my $i (0 .. $#$mtr) 
     {
          for my $j (0 .. $#{$mtr->[0]}) 
          {
               if ($i == 0 or $j == 0) 
               {
                    $curr_row[$j] = $mtr->[$i][$j];
               } 
               elsif ($mtr->[$i][$j] == 1) 
               {
                    $curr_row[$j] = min($prev_row[$j], $curr_row[$j - 1], $prev_row[$j - 1]) + 1;
               } 
               else 
               {
                    $curr_row[$j] = 0;
               }
               $max_side = max($max_side, $curr_row[$j]);
          }
          @prev_row = @curr_row;
     }

     return $max_side * $max_side;
}