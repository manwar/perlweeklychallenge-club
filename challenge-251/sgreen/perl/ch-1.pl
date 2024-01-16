#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my $solution = 0;
    my $half     = int( scalar(@ints) / 2 );

    # If we have an odd number of integers, use the middle value
    if ( $#ints % 2 == 0 ) {
        $solution += $ints[$half];
    }

    # Combine the concatenation of the remaining integers, starting with first
    #  and last, then second and second last, and so on.
    foreach my $i ( 0 .. $half - 1 ) {
        $solution += ( $ints[$i] . $ints[ -1 - $i ] );
    }

    say $solution;
}

main(@ARGV);