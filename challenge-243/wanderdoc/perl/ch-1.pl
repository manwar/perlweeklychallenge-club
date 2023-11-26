#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers. Write a script to return the number of reverse pairs in the given array.
A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].
Example 1
Input: @nums = (1, 3, 2, 3, 1)
Output: 2
(1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1

Example 2
Input: @nums = (2, 4, 3, 5, 1)
Output: 3
(1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
(2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1
=cut
use Test2::V0;

sub reverse_pairs
{
     my @arr = @_;
     my @output;
     for my $i ( 0 .. $#arr -1 )
     {
          for my $j ( $i + 1 .. $#arr )
          {
               if ( $arr[$i] > 2 * $arr[$j] )
               {
                    push @output, [$i, $j];
               }
          }
     }
     return @output;
}


is([reverse_pairs(1, 3, 2, 3, 1)], [[1,4],[3,4]], 'Example 1');
is([reverse_pairs(2, 4, 3, 5, 1)], [[1,4],[2,4],[3,4]], 'Example 2');
done_testing();