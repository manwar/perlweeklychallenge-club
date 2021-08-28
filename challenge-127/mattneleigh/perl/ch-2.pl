#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @inputs = (
    [ [1, 4], [3, 5], [6, 8], [12, 13], [3, 20] ],
    [ [3, 4], [5, 7], [6, 9], [10, 12], [13, 15] ]
);
my $intervals;
my @overlaps;
my @strings;

foreach $intervals (@inputs){
    @strings = ();

    # Complicated output with nested
    # comma-separated lists...
    printf(
        "Input: \@Intervals = [ %s ]\n",
        join(
            ", ",
            map(
                { sprintf("(%s)", join(", ", @{$_})); }
                @{$intervals}
            )
        )
    );

    @overlaps = find_previous_overlaps(@{$intervals});

    # Even more complicated output with
    # nested comma-separated lists...
    # for-loop because we need to know
    # where in the list we are when we
    # find something
    for my $i (0 .. $#overlaps){
        # We don't actually care what the
        # overlaps are in this case- it's
        # enough to know which intervals
        # have them
        if(scalar(@{$overlaps[$i]})){
            push(
                @strings,
                sprintf("(%s)", join(", ", @{$intervals->[$i]}))
            );
        }
    }
    printf("Output: [ %s ]\n", join(", ", @strings));

    print("\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find overlaps between numerical intervals in a list and previous (but not
# subsequent) intervals within that list
# Takes one argument:
# * A list of refs to intervals- arrays containing two numerical values, which
#   must appear in ascending order (e.g. [1, 5] but not [7, 3])
# Returns:
# * A list of refs to arrays containing the indices of overlapping intervals
#   found earlier in the original interval list; the position of each array in
#   this list corresponds to the position of the member of the argument list
#   that was being checked for previous overlaps.  If no overlaps were found
#   for that interval, the corresponding array in the returned list will be
#   empty.  As there are no previous arguments to check for the first interval,
#   the first returned array will always be empty.
#
# Example:
#   @intervals = ( [3, 5], [7, 10], [6, 8], [4, 9] );
#   @overlaps = find_previous_overlaps(@intervals);
#   # @overlaps contains:
#   # ( [], [], [ 1 ], [ 0, 1, 2 ] )
#
################################################################################
sub find_previous_overlaps{

    my $i;
    my $j;
    my $overlap_intervals;
    my @return_intervals;

    # Add an empty list for the 0th interval
    # as it can't overlap with any previous one
    @return_intervals = ( [] );

    # Loop over intervals from the 1th (as
    # opposed to the 1st) onward
    for $i (1 .. $#ARG){
        $overlap_intervals = [];

        # Loop over intervals from the 0th to the
        # (i - 1)th
        for $j (0 .. ($i - 1)){
            # Basically:
            # if(max(beginnings) - min(ends) <= 0)
            if(
                # Maximum of the beginnings of the ranges
                ($ARG[$j][0] > $ARG[$i][0] ? $ARG[$j][0] : $ARG[$i][0])
                - 
                # Minimum of the ends of the ranges
                ($ARG[$j][1] < $ARG[$i][1] ? $ARG[$j][1] : $ARG[$i][1])
                <=
                0
            ){
                # The jth interval overlaps with the
                # ith- store j
                push(@{$overlap_intervals}, $j);
            }
        }

        # Store the list of intervals that
        # overlapped with the ith, empty or
        # not
        push(@return_intervals, $overlap_intervals);
    }

    return(@return_intervals);

}



