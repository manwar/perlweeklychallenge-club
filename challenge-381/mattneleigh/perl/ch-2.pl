#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 2, 4 ],
    [ 1, 1, 1, 1 ],
    [ 1, 1, 4, 8, 12, 12 ],
    [ 3, 6, 6, 9 ],
    [ 0, -5, 10, -2, 4 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@int = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        count_surrounded_elements(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, determine how many elements therein are neither
# the lowest value nor the highest within the array
# Takes one argument:
# * The list of integers to examine (e.g. ( 1, 1, 4, 8, 12, 12 ) )
# Returns:
# * The number of integers in the provided list that have at least one value
#   both higher and lower in value than themselves (e.g. 2)
################################################################################
sub count_surrounded_elements{
    # Sort the integer list for easier processing
    my @ints = sort({ $a <=> $b} @ARG);

    # There must be at least three ints in the
    # array
    return(0)
        if(@ints < 3);

    my $i = 0;

    # Delete all the ints at the start of the
    # sorted array that have the same value
    while((++$i < @ints) && ($ints[$i] == $ints[0])){
        ;;
    }
    splice(@ints, 0, $i);

    # Do the same for all the ints at the end of
    # the array, if there are any present
    if(@ints){
        $i = $#ints;
        while((--$i >= 0) && ($ints[$i] == $ints[-1])){
            ;;
        }
        splice(@ints, $i + 1);
    }

    # The ints that are left, if any, are those
    # that were neither the highest nor lowest
    # values in the array
    return(scalar(@ints));

}



