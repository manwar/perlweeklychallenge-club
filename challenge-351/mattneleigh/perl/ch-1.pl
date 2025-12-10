#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 8000, 5000, 6000, 2000, 3000, 7000 ],
    [ 100000, 80000, 110000, 90000 ],
    [ 2500, 2500, 2500, 2500 ],
    [ 2000 ],
    [ 1000, 2000, 3000, 4000, 5000, 6000 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        average_without_outliers(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, calculate the average of all elements EXCEPT the
# minimum and maximum values; note that if multiple elements have the maximum
# or minimum values, all will be removed before the average is calculated
# Takes one argument:
# * The array of integers to examine (e.g. (1, 2, 3, 2, 4, 5, 6, 3) )
# Returns:
# * The average of the integers in the array, less all members that are equal
#   to the smallest and largest values in the array (e.g.  3 )
################################################################################
sub average_without_outliers{
    # Sort the given ints in ascending order
    my @ints = sort({ $a <=> $b } @ARG);

    my $value;

    # Nibble off the lowest and highest values, including
    # duplicates if present; if nothing remains, we bail
    $value = $ints[0];
    while(@ints && ($ints[0] == $value)){
        shift(@ints);
    }
    return(0)
        unless(@ints);

    $value = $ints[-1];
    while(@ints && ($ints[-1] == $value)){
        pop(@ints);
    }
    return(0)
        unless(@ints);

    # Sum the remaining ints
    $value = 0;
    foreach my $int (@ints){
        $value+= $int;
    }

    # Compute the average and return
    return($value / scalar(@ints));

}



