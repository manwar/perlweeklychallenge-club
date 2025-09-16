#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 5, 9, 3, 4, 6 ],
    [ 1, -2, 3, -4 ],
    [ -3, -1, -2, -4 ],
    [ 10, 2, 0, 5, 1 ],
    [ 7, 8, 9, 10, 10 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        maximum_pair_difference(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers with at least four elements, determine the maximum
# difference between the product of any two pairs in the list (i.e. two pairs
# (a, b) and (c, d) such that the product difference (a * b) - (c * d) is the
# greatest possible within the list)
# Takes one argument:
# * A list of integers to examine (e.g. (10, 2, 0, 5, 1) )
# Returns:
# * The maximum product difference of an two pairs within the list (e.g. 50)
################################################################################
sub maximum_pair_difference{
    # Sort the list so the numbers farthest from zero
    # are at the end of the list
    my @ints = sort({ abs($a) <=> abs($b) } @ARG);

    # Calculate and return the difference between
    # the products of the two values farthest from
    # zero and the two values closest to zero
    return(
        abs(
            ($ints[-1] * $ints[-2])
            -
            ($ints[0] * $ints[1])
        )
    );

}



