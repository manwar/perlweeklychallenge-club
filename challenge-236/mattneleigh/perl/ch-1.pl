#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @denominations = (20, 10, 5);
my @bill_sequences = (
    [ 5, 5, 5, 10, 20 ],
    [ 5, 5, 10, 10, 20 ],
    [ 5, 5, 5, 20 ]
);
my $price = 5;

print("\n");
foreach my $bills (@bill_sequences){
    printf(
        "Input: \@bills = (%s)\nOutput: %s\n\n",
        join(", ", @{$bills}),
        exact_change_possible($price, \@denominations, @{$bills}) ?
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
# Determine whether exact change can be made from a given sequence of
# transactions, starting with an empty till
# Takes three arguments:
# * The price of the item being sold (e.g. 5)
# * A ref to an array of the denominations available for payment and change-
#   making (e.g. [ 20, 10, 5 ] )
# * A list of single-bill amounts indicating the payments made in a sequence of
#   transactions
# Returns:
# * 1 if exact change could be made for the entire sequence of transactions
# * 0 if exact change could NOT be made for the entire sequence of transactions
################################################################################
sub exact_change_possible{
    my $price = shift();

    # Sort denominations in descending order so we
    # can take a "greedy" approach to making change
    # (see below)
    my @denoms = sort({ $b <=> $a } @{shift()});

    my %till;

    # Set up an empty till
    foreach my $denom (@denoms){
        $till{$denom} = 0;
    }

    # Loop over each transaction
    foreach my $payment (@ARG){
        # Put this payment in the till
        $till{$payment}++;

        # Skip ahead if the customer paid with
        # exact change
        next
            if($payment == $price);

        # We owe change back...
        $payment -= $price;
        
        # Loop over each denomination- using larger
        # denominations first (see above)
        foreach my $denom (@denoms){
            while($till{$denom} && ($denom <= $payment)){
                # We have this denomination and it's
                # greater than the change owed- use one
                $till{$denom}--;
                $payment -= $denom;
            }
        }

        # If we still owe money, we couldn't make
        # exact change for this transaction
        return(0)
            if($payment);
    }

    # We were able to make exact change for
    # all transactions
    return(1);

}



