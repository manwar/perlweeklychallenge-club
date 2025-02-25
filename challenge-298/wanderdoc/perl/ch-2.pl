#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of @intervals, where $intervals[i] = [starti, endi] and each starti is unique.

The right interval for an interval i is an interval j such that startj >= endi and startj is minimized. Please note that i may equal j.

Write a script to return an array of right interval indices for each interval i. If no right interval exists for interval i, then put -1 at index i.
Example 1

Input: @intervals = ([3,4], [2,3], [1,2])
Output: (-1, 0, 1)

There is no right interval for [3,4].
The right interval for [2,3] is [3,4] since start0 = 3 is the smallest start that is >= end1 = 3.
The right interval for [1,2] is [2,3] since start1 = 2 is the smallest start that is >= end2 = 2.

Example 2

Input: @intervals = ([1,4], [2,3], [3,4])
Output: (-1, 2, -1)

There is no right interval for [1,4] and [3,4].
The right interval for [2,3] is [3,4] since start2 = 3 is the smallest start that is >= end1 = 3.

Example 3

Input: @intervals = ([1,2])
Output: (-1)

There is only one interval in the collection, so it outputs -1.

Example 4

Input: @intervals = ([1,4], [2, 2], [3, 4])
Output: (-1, 1, -1)


=cut

use Test2::V0 -no_srand => 1;
is([right_interval([3,4], [2,3], [1,2])], [(-1, 0, 1) ], 'Example 1');
is([right_interval([1,4], [2,3], [3,4])], [(-1, 2, -1)], 'Example 2');
is([right_interval([1,2])], [(-1)], 'Example 3');
is([right_interval([1,4], [2, 2], [3, 4])], [(-1, 1, -1)], 'Example 4');
done_testing();


sub right_interval
{
     my @arr = @_;
     my @output;
     for my $idx_i ( 0 .. $#arr )
     {
          my @candidates = 
               sort { $a->[0] <=> $b->[0] }
               grep { $_->[0] >= $arr[$idx_i][1] }
               map  {[$arr[$_]->[0], $_]} ( 0 .. $#arr );

          my $min_right = $candidates[0][1];
          $output[$idx_i] = $min_right // -1;
     }
     return @output;
}