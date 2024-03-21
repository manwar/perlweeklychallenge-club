#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 2, 3, 45 ],
    [ 1, 12, 3 ],
    [ 1, 2, 3, 4 ],
    [ 236, 416, 336, 350 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        calculate_absolute_difference(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the absolute difference between the sum of the elements of a list
# of positive integers, and the sum of all the digits within each integer in
# the list
# Takes one argument:
# * The list of integers to examine (e.g. ( 1, 12, 3 ) )
# Returns:
# * The absolute difference between the sum of the elements and the sum of the
#   digits within every element (e.g. 9 )
################################################################################
sub calculate_absolute_difference{

    my $element_sum = 0;
    my $digit_sum = 0;

    foreach my $element (@ARG){
        # Add each number- and all its digits-
        # to separate running totals
        $element_sum += $element;
        foreach my $digit (split(//, $element)){
            $digit_sum += $digit;
        }
    }

    # Calculate the absolute value of the
    # difference between the two totals
    return(abs($element_sum - $digit_sum));

}



