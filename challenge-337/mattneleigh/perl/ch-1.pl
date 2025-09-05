#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 6, 5, 4, 8 ],
    [ 7, 7, 7, 7 ],
    [ 5, 4, 3, 2, 1 ],
    [ -1, 0, 3, -2, 1 ],
    [ 0, 1, 1, 2, 0 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@num1 = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", count_lesser_instances(@{$integer_list})),
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of numbers, determine how many numbers within the array have a
# value less than or equal to each individual number, NOT including itself
# Takes one argument:
# * An array of integers to examine (e.g. (-1, 0, 3, -2, 1) )
# Returns:
# * An array that corresponds to the given array, such that each element in the
#   array returned is a count of elements in the original array that are less
#   than or equal to the value of the element at that position, NOT including
#   itself (e.g. (1, 2, 4, 0, 3) )
################################################################################
sub count_lesser_instances{

    my $int;
    my @sorted_counts;
    my $current_count;

    # Count instances of every value in the given
    # list, and produce a sorted list of these
    # values and their instance counts
    {
        my %instance_counts;

        foreach $int (@ARG){
            $instance_counts{$int}++;
        }
        @sorted_counts = map(
            [ $_, $instance_counts{$_} ],
            sort({ $a <=> $b } keys(%instance_counts))
        );
    }

    return(
        map(
            # Run this block on every value from the gven
            # list
            {
                $current_count = 0;

                # Loop over the sorted counts of each instance
                foreach my $instance_count (@sorted_counts){
                    if($instance_count->[0] == $_){
                        # This count is of values that equal the
                        # current one- add one less than this count
                        # to the total and break out of the loop
                        $current_count += $instance_count->[1] - 1;
                        last;
                    } else{
                        # This count is of a value that is not equal
                        # to the current one- add this count to the
                        # total
                        $current_count += $instance_count->[1];
                    }
                }

                $current_count;
            }
            @ARG
        )
    );

}



