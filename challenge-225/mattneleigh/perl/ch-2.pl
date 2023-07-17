#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 10, 4, 8, 3 ],
    [ 1 ],
    [ 1, 2, 3, 4, 5 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", calculate_left_right_sum_diff(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the left-right sum difference of a list of integers
# Takes one argument:
# * A list of integers to examine (e.g. ( 1, 2, 3, 4, 5 ) )
# Returns:
# * A list of the left-right sum differences (e.g. ( 14, 11, 6, 1, 10 ) )
################################################################################
sub calculate_left_right_sum_diff{

    my @left = (0);
    my $left_sum = 0;
    my @right = (0);
    my $right_sum = 0;

    # Calculate/store lists of the left and
    # right sums
    for my $i (0 .. $#ARG - 1){
        # Build the left list forward
        push(@left, $left_sum += $ARG[$i]);
        # Build the right list backward
        unshift(@right, $right_sum += $ARG[$#ARG - $i]);
    }

    # Return a list of the absolute values of
    # the difference between the left and right
    # sums
    return(
        map(
            abs($left[$_] - $right[$_]),
            0 .. $#ARG
        )
    );

}



