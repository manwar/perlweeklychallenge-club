#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @amounts = (
    9, 15, 100
);
my @denominations = (
    1, 5, 10, 25, 50
);

print("\n");
foreach my $amount (@amounts){
    printf(
        "Input: \$amount = %d\nOuput: %d\n\n",
        $amount,
        count_change_permutations($amount, \@denominations)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Compute the number of ways to make change for a given amount of money, using
# a specified set of coins or notes of denominations in the same unit as the
# specified amount- these could be cents, dollars, pounds, etc. as long as all
# quantities are specified in the same units
# Takes two arguments:
# * An amount of money for which change must be made (e.g. 100 )
# * A ref to an array containing the denominations of coins or notes available
#   (e.g.
#       [ 1, 5, 10, 25, 50 ]
#   )
# Returns:
# * The number of ways the specified amount of money can be made using coins or
#   notes of the denominations provided (e.g. 292 )
# Method adapted from pseudocode presented here:
# https://math.stackexchange.com/questions/176363/keep-getting-generating-function-wrong-making-change-for-a-dollar/176397#176397
################################################################################
sub count_change_permutations{
    my $amount = shift();
    my $denominations = shift();

    # The coefficients beyond index 0 will be autovivified
    my @coefs = (1);

    # Loop over each denomination
    foreach my $denomination (@{$denominations}){
        # Loop from zero to the amount less the current
        # denomination
        for my $i (0 .. $amount - $denomination){
            $coefs[$i + $denomination] += $coefs[$i];
        }
    }

    # The coefficient at the index corresponding to the
    # target amount has the number of ways change can be
    # made with the given denominations
    return($coefs[$amount]);

}



