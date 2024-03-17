#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Calculate the frequency of each integer
    my %freq = ();
    foreach my $i (@ints) {
        $freq{$i}++;
    }

    # Return if we have seen a frequency already
    my %seen = ();
    foreach my $i ( values(%freq) ) {
        if ( exists $seen{$i} ) {
            say '0';
            return;
        }

        $seen{$i} = 1;
    }

    # We have a unique orrurrence list
    say '1';
}

main(@ARGV);