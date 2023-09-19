#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    # Given cases
    [ 0, 2, 9, 4, 6 ],
    [ 5, 1, 3, 2 ],
    [ 2, 2, 3 ],

    # Additional test case(s)
    [ 1, 2, 3, 4, 5, 6 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %s\n\n",
        join(", ", @{$integer_list}),
        array_has_one_non_increasing_element(@{$integer_list}) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether an array of numbers has one (and only one) non-increasing
# element; that is to say, there is one element $i such that
# $array[$i-1] >= $array[$i]
# Takes one argument:
# * A list of numbers to examine
# Returns:
# * 1 if there is one (and only one) non-increasing value in the array
# * 0 if there are zero, two, or more non-increasing values in the array
################################################################################
sub array_has_one_non_increasing_element{

    my $non_increasing_seen = 0;

    # Loop over the array from 1 to n-1
    for my $i (1 .. $#ARG){
        unless($ARG[$i - 1] < $ARG[$i]){
            # Previous value was not lower than the
            # current value...

            # See if we've already encountered such
            # a situation, and return 0 if we have
            return(0)
                if($non_increasing_seen);

            # Note that weve seen a non-increasing
            # value
            $non_increasing_seen = 1;
        }
    }

    # This will be 1 if there was one
    # non-increasing pair, or 0 if there were
    # none
    return($non_increasing_seen);

}



