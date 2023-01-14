#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@list) {
    # Calculate the frequency of each integer
    my %freq = ();
    foreach my $i (@list) {
        $freq{$i}++;
    }

    my $solution = 0;
    foreach my $f ( values(%freq) ) {
        # If a value appears more than once, calculate the number of
        #  combinations. This is the sum of 1 + ... + f-1.
        if ( $f > 1 ) {
            $solution += $f * ( $f - 1 ) / 2;
        }
    }

    # Display the output
    say $solution;
}

main(@ARGV);