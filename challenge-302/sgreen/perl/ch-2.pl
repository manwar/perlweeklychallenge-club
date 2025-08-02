#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Calculate the minimum running total
    my $min_value = $ints[0];
    my $value     = 0;
    foreach my $i (@ints) {
        $value += $i;
        if ( $min_value > $value ) {
            $min_value = $value;
        }
    }
    if ( $min_value >= 0 ) {
        # No negative total found. Return the lowest positive integer
        say 1;
    }
    else {
        # Return the number to start with
        say 1 - $min_value;
    }
}

main(@ARGV);