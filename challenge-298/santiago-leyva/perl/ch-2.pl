=begin
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

use strict;
use warnings;
use Data::Dumper;
use List::Util qw(min);
use POSIX qw(floor);

sub findRightInterval {
    my @intervals = @_;
    my @result;

    # Create a list of intervals with their original indices
    my @indexed_intervals = ();
    for my $i (0 .. $#intervals) {
        push @indexed_intervals, [$intervals[$i][0], $intervals[$i][1], $i];
    }

    # Sort intervals by their start values
    @indexed_intervals = sort { $a->[0] <=> $b->[0] } @indexed_intervals;

    for my $i (0 .. $#intervals) {
        my $end = $intervals[$i][1];
        my $left = 0;
        my $right = $#indexed_intervals;
        my $ans = -1;

        # BS
        while ($left <= $right) {
            my $mid = int(($left + $right) / 2);
            if ($indexed_intervals[$mid][0] >= $end) {
                $ans = $indexed_intervals[$mid][2]; 
                $right = $mid - 1;
            } else {
                $left = $mid + 1;
            }
        }
        push @result, $ans;
    }

    return @result;
}

my @intervals1 = ([3, 4], [2, 3], [1, 2]);
print "Result: ", join(", ", findRightInterval(@intervals1)), "\n";  

my @intervals2 = ([1, 4], [2, 3], [3, 4]);
print "Result: ", join(", ", findRightInterval(@intervals2)), "\n";  

my @intervals3 = ([1, 2]);
print "Result: ", join(", ", findRightInterval(@intervals3)), "\n"; 