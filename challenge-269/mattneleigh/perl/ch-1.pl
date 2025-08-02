#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 2, 3, 4, 5 ],
    [ 2, 3, 8, 16 ],
    [ 1, 2, 5, 7, 9 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %s\n\n",
        join(", ", @{$integer_list}),
        bitwise_OR_least_sig_bit_possible(@{$integer_list}) ?
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
# Determine whether a list of positive integers contains at least two numbers
# that would, if bitwise-OR'd together, yield an integer with a zero in the
# least significant bit
# Takes one argument:
# * A list of positive integers to exmaine (e.g. ( 1, 2, 3, 4, 5 ) )
# Returns:
# * 1 if there are at least two integers that, if bit-wise OR'd together, would
#   yield a zero in the least-significant bit
# * 0 if there are NOT at least two integers that, if bit-wise OR'd together,
#   would yield a zero in the least significant bit
################################################################################
sub bitwise_OR_least_sig_bit_possible{

    my $zeros = 0;

    # Loop over each integer- the secret is
    # to count the zeros in the ones-place
    # bit; if we find two of those we know
    # to return true
    foreach my $int (@ARG){
        # Add to the count of zeros if this int's
        # ones-place bit is zero
        $zeros++
            unless($int & 0x01);

        # If we have found more than one such
        # int, return true
        return(1)
            if($zeros > 1)
    }

    # Found zero or one ints with a zero in
    # the ones-place bit
    return(0);

}



