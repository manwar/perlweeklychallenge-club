#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @arrays = (
    [ 1, 2, 3, 4, 5, 6, 7 ],
    [ 2, 4, 1, 3 ],
    [ 10, 5, 7, 12, 8 ]
);

print("\n");
foreach my $array (@arrays){
    printf(
        "Input: \@array = (%s)\nOutput: %d\n\n",
        join(", ", @{$array}),
        calculate_max_pair_xor(@{$array})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the maximum value that can be produced by XORing any pair of
# elements within a given array
# Takes one argument:
# * The array to examine
# Returns:
# * The maximum value found by XORing every pair of elements within the
#   provided array
################################################################################
sub calculate_max_pair_xor{

    my $max_xor = 0;

    # Loop in such a way that $i and $j will
    # refer to every possible combination of two
    # array elements
    for my $i (0 .. $#ARG - 1){
        for my $j ($i + 1 .. $#ARG){
            my $pair_xor = $ARG[$i] ^ $ARG[$j];

            # Store this pair's XOR'd value if it's
            # the largest yet seen
            $max_xor = $pair_xor
                if($pair_xor > $max_xor);
        }
    }

    return($max_xor);

}



