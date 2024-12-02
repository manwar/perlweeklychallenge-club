#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @interval_sets = (
    [
        [ 3, 4 ], [ 2, 3 ], [ 1, 2 ]
    ],
    [
        [ 1, 4 ], [ 2, 3 ], [ 3, 4 ]
    ],
    [
        [ 1, 2 ]
    ],
    [
        [ 1, 4 ], [ 2, 2 ], [ 3, 4 ]
    ]
);

print("\n");
foreach my $interval_set (@interval_sets){
    printf(
        "Input: \@intervals = (%s)\nOutput: (%s)\n\n",
        join(
            ", ",
            map(
                "[" . join(", ", @{$_}) . "]",
                @{$interval_set}
            )
        ),
        join(", ", find_right_intervals(@{$interval_set}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of intervals of the form [ start, end ] with each start being
# unique, determine the index of the Right Interval within the list for each-
# that is to say, the Right Interval j for interval i is one in which
# startj >= endi, and startj has the lowest value amongst any intervals that
# meet the first criteria.  Note that it is possible for an interval to be its
# own Right Interval if its length is zero.
# Takes one argument:
# * The array of intervals (e.g. ( [ 3, 4 ], [ 2, 3 ], [ 1, 2 ] ) )
# Returns:
# * An array of indices of Right Intervals corresponding to the supplied
#   intervals; if there were no Right Intervals found for a given interval, -1
#   will be returned in that position (e.g. ( -1, 0, 1 ) )
################################################################################
sub find_right_intervals{
    my @intervals = @ARG;

    my $i;
    my $j;
    my $min_interval;
    my $min_index;
    my @right_intervals;

    # Loop over each interval $i
    for $i (0 .. $#intervals){
        $min_interval = undef;
        $min_index = -1;

        # Loop over each interval $j
        for $j (0 .. $#intervals){
            # Store this interval and its index if it's a Right
            # Interval- the start of $j >= the end of $i and
            # the start $j is minimum seen in the set so far
            if(
                ($intervals[$j][0] >= $intervals[$i][1])
                &&
                (
                    # Check if we have an interval defined already; we
                    # will store it if not
                    !defined($min_interval)
                    ||
                    ($intervals[$j][0] < $min_interval->[0])
                )
            ){
                $min_interval = $intervals[$j];
                $min_index = $j;
            }
        }

        # Store the index of the Right Interval found,
        # which will still be -1 if there was none
        push(@right_intervals, $min_index);
    }

    return(@right_intervals);

}



