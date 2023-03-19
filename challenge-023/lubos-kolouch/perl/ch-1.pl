#!/usr/bin/perl

use strict;
use warnings;

sub forward_difference {
    my ($order, $nums_ref) = @_;

    my @nums = @$nums_ref;

    # Check if valid order is passed
    die "Order should be a positive integer\n" if $order < 1;

    my @diff = @nums;

    # Calculate the nth order forward difference series
    for (my $i = 1; $i <= $order; $i++) {
        my @temp = ();
        for (my $j = 0; $j < $#diff; $j++) {
            push @temp, $diff[$j+1] - $diff[$j];
        }
        @diff = @temp;
    }

    # Return the final series
    return @diff;
}

