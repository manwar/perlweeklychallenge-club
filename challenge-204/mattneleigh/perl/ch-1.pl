#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @arrays = (
    # Given cases
    [ 1, 2, 2, 3 ],
    [ 1, 3, 2 ],
    [ 6, 5, 5, 4 ],

    # Additional test cases
    [ 2, 2, 2, 4 ],
    [ 2, 2, 2, 0 ],
    [ 4, 2, 2, 2 ],
    [ 0, 2, 2, 2 ]
);

print("\n");
foreach my $array (@arrays){
    printf(
        "Input: \@nums = (%s)\nOutput: %d\n\n",
        join(", ", @{$array}),
        array_is_monotonic(@{$array})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether an array of numbers is monotonic- that is to say:
# for every i <= j, array[i] <= array[j] (monotone increasing)
# - OR -
# for every i <= j, array[i] >= array[j] (monotone decreasing)
# Takes one argument:
# * The list to examine
# Returns:
# * 1 if the array is monotonic, as defined above
# * 0 if the array is not monotonic
# NOTE: this function does not differentiate between the two kinds of
# monotonicity
################################################################################
sub array_is_monotonic{

    my $i = 0;
    my $direction = 0;

    # Loop over the array, examining each pair
    # of values- pairs of equal values don't
    # preclude monotonicity of either type so
    # they're effectively ignored
    for my $i (1 .. $#ARG){
        if($ARG[$i - 1] < $ARG[$i]){
            # An ascending pair
            if($direction < 0){
                # $direction was less than zero-
                # we'd seen descending values before
                return(0);
            }
            $direction = 1;
        }
        if($ARG[$i - 1] > $ARG[$i]){
            # A descending pair
            if($direction > 0){
                # $direction was greater than zero-
                # we'd seen ascending values before
                return(0);
            }
            $direction = -1;
        }
    }

    return(1);
    
}



