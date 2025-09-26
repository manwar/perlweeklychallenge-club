#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of altitude gain.
Write a script to find the peak point gained.

Example 1

Input: @gain = (-5, 1, 5, -9, 2)
Output: 1

start: 0
1st change:  0 + (-5) = -5
2nd change: -5 + 1    = -4
3rd change: -4 + 5    = 1
4th change:  1 + (-9) = -8
5th change: -8 + 2    = -6

max(0, -5, -4, 1, -8, -6) = 1


Example 2

Input: @gain = (10, 10, 10, -25)
Output: 30

start: 0
1st change:  0 + 10    = 10
2nd change: 10 + 10    = 20
3rd change: 20 + 10    = 30
4th change: 30 + (-25) = 5

max(0, 10, 20, 30, 5) = 30


Example 3

Input: @gain = (3, -4, 2, 5, -6, 1)
Output: 6

start: 0
1st change:  0 + 3    = 3
2nd change:  3 + (-4) = -1
3rd change: -1 + 2    = 1
4th change:  1 + 5    = 6
5th change:  6 + (-6) = 0
6th change:  0 + 1    = 1

max(0, 3, -1, 1, 6, 0, 1) = 6


Example 4

Input: @gain = (-1, -2, -3, -4)
Output: 0

start: 0
1st change:  0 + (-1) = -1
2nd change: -1 + (-2) = -3
3rd change: -3 + (-3) = -6
4th change: -6 + (-4) = -10

max(0, -1, -3, -6, -10) = 0


Example 5

Input: @gain = (-10, 15, 5)
Output: 10

start: 0
1st change:   0 + (-10) = -10
2nd change: -10 + 15    = 5
3rd change:   5 + 5     = 10

max(0, -10, 5, 10) = 10

=cut

use Test2::V0 -no_srand => 1;

is(peak_point(-5, 1, 5, -9, 2), 1, 'Example 1');
is(peak_point(10, 10, 10, -25), 30, 'Example 2');
is(peak_point(3, -4, 2, 5, -6, 1), 6, 'Example 3');
is(peak_point(-1, -2, -3, -4), 0, 'Example 4');
is(peak_point(-10, 15, 5), 10, 'Example 5');
done_testing();

sub peak_point
{
     my @arr = @_;
     my $sum;
     my $max = 0;
     for my $elm ( @arr )
     {
          $sum += $elm;
          $max = $max > $sum ? $max : $sum;
     }
     return $max;
}
