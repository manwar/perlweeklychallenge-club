#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main(@n) {
    # Count the number of sequential odd numbers
    my $odds = 0;

    foreach my  $i (@n) {
        if ($i % 2 == 1) {
            $odds++;
        
            if ($odds == 3) {
                # We have found three sequential odd numbers
                say '1';
                return;
            }
        }
        else {
            # Restart the count
            $odds = 0;
        }
    }

    # There is no solution
    say '0';
}

main(@ARGV);