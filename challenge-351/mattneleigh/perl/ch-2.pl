#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @number_lists = (
    [ 1, 3, 5, 7, 9 ],
    [ 9, 1, 7, 5, 3 ],
    [ 1, 2, 4, 8, 16 ],
    [ 5, -1, 3, 1, -3 ],
    [ 1.5, 3, 0, 4.5, 6 ]
);

print("\n");
foreach my $number_list (@number_lists){
    printf(
        "Input: \@num = (%s)\nOutput: %s\n\n",
        join(", ", @{$number_list}),
        is_arithmetic_sequence(@{$number_list}) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of numbers, determine whether its members can be rearranged
# to form an arithmetic progression- that is to say, they can form a sequence
# of numbers in which the differences between all pairs of adjacent elements
# are the same
# Takes one argument:
# * The array of integers to examine (e.g. (1.5, 3, 0, 4.5, 6) )
# Returns:
# * 0 if the supplied array CAN'T be rearranged to form an arithmetic
#   progression
# * 1 if the supplied array can be rearranged to form an arithmetic progression
#   (As would be the case in the example above)
################################################################################
sub is_arithmetic_sequence{
    # Sort the integers in ascending order
    my @ints = sort({ $a <=> $b; } @ARG);

    # Establish an initial difference between the first
    # and second elements of the sorted array
    my $diff = $ints[1] - $ints[0];

    # Loop over remaining indices
    for my $i (2 .. $#ints){
        # Bail if we find a different difference
        return(0)
            unless($ints[$i] - $ints[$i - 1] == $diff);
    }

    # Got here- the array contained an arithmetic
    # sequence
    return(1);

}



