#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ -1, -2, -3, -4, 3, 2, 1 ],
    [ 1, 2, 0, -2, -1 ],
    [ -1, -1, 1, -1, 2 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        list_product_sign(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the sign of the product that would result from multiplying
# together all members of a list of integers
# Takes one argument:
# * A list of integers to examine (e.g. ( -1, -2, -3, -4, 3, 2, 1 ) )
# Returns:
# * -1 if the sign of the product would be negative
# * 0 if the product would be zero
# * 1 if the sign of the product would be positive
################################################################################
sub list_product_sign{

    my $negatives = 0;

    foreach my $int (@ARG){
        # If an int is zero, the product of the list
        # will be zero
        return(0)
            unless($int);

        # Increment the negative count if this int
        # is below zero
        $negatives++
            if($int < 0);
    }

    return(
        $negatives % 2 ?
            # Negative count is odd- product would be
            # negative
            -1
            :
            # Negative count is even- product would be
            # positive
            1
    );

}



