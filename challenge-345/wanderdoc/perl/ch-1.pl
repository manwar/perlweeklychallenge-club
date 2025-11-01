#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.
Find all the peaks in the array, a peak is an element that is strictly greater than its left and right neighbours. Return the indices of all such peak positions.

Example 1

Input: @ints = (1, 3, 2)
Output: (1)


Example 2

Input: @ints = (2, 4, 6, 5, 3)
Output: (2)


Example 3

Input: @ints = (1, 2, 3, 2, 4, 1)
Output: (2, 4)


Example 4

Input: @ints = (5, 3, 1)
Output: (0)


Example 5

Input: @ints = (1, 5, 1, 5, 1, 5, 1)
Output: (1, 3, 5)

=cut


use Test2::V0 -no_srand => 1;

is([peak_positions(1, 3, 2)], [1], 'Example 1');
is([peak_positions(2, 4, 6, 5, 3)], [2], 'Example 2');
is([peak_positions(1, 2, 3, 2, 4, 1)], [2, 4], 'Example 3');
is([peak_positions(5, 3, 1)], [0], 'Example 4');
is([peak_positions(1, 5, 1, 5, 1, 5, 1)], [1, 3, 5], 'Example 5');
done_testing();

sub peak_positions
{
     my @arr = @_;
     if ( scalar(@arr) == 1) { return 0; } 
     my @positions;
     for my $idx ( 0 .. $#arr )
     {
          if ( 
               ($idx == 0 and $arr[$idx] > $arr[$idx+1]) or 
               ($idx < $#arr  and $arr[$idx] > $arr[$idx-1] 
                              and $arr[$idx] > $arr[$idx+1]) or
               ($idx == $#arr and $arr[$idx] > $arr[$idx-1])
          )
          {
               push @positions, $idx;
          }
     }
     return @positions;
}
