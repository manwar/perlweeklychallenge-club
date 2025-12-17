#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @number_lists = (
    [ 0, 1, 1, 0, 0, 1, 0, 1, 1, 1 ],
    [ 1, 0, 1, 0, 1, 0 ],
    [ 0, 0, 1, 0, 1 ],
    [ 1, 1, 1, 1, 1 ],
    [ 1, 0, 1, 1, 0, 1, 0, 0, 1, 1 ]
);

print("\n");
foreach my $number_list (@number_lists){
    printf(
        "Input: \@nums = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$number_list}),
        join(
            ", ",
            map(
                $_ ? "true" : "false",
                bits_divisible_by_five(@{$number_list})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of ones and zeros, place each into the least significant bit
# of an integer value, shifting all extant bits to the left to accommodate it,
# and determine whether the resulting value is divisible by five (5).
# Takes one argument:
# * The list of bits to examine (e.g. (1, 0, 1, 0, 1, 0) )
# Returns:
# * A list of ones and zeros corresponding to each bit in the input array,
#   with zero (0) indicating that the value constructed using the bit in
#   question was NOT divisible by five (5) and a one (1) indicating that it was
#   divisible by five (5) (e.g. (0, 0, 1, 1, 0, 0) )
################################################################################
sub bits_divisible_by_five{

    my $num = 0;
    my @divisible;

    # Examine each supplied bit
    foreach my $bit (@ARG){
        # Determine whether adding this new bit as the least
        # significant one in the current value makes it
        # divisible by five, and store a 1 or 0 accordingly
        $num <<= 1;
        $num += $bit;
        push(@divisible, $num % 5 ? 0 : 1);
    }

    return(@divisible);

}



