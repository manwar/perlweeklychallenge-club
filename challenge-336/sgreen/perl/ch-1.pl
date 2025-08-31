#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(all min max);

sub main (@ints) {
    # Calculate the frequency of each integer in the list
    my %freq = ();
    $freq{$_}++ foreach @ints;
    my @values = values %freq;

    # If any integer appears only once, it is always false.
    if ( min(@values) == 1 ) {
        say 'false';
        return;
    }

    # Check if all frequencies are evenly divisible by an integer.
    foreach my $i ( 2 .. max(@values) ) {
        if ( all { $_ % $i == 0 } @values ) {
            say 'true';
            return;
        }
    }

    say 'false';
}

main(@ARGV);
