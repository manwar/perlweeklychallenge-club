#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'any';

sub main {
    my @numbers = ( join( ' ', @_ ) =~ /(\d+)/g );

    # Sanity check and pair up numbers
    die "You must provide an even amount of numbers" if $#numbers % 2 == 0;

    my @sets  = ();
    my @match = ();

    while (@numbers) {
        my $first = shift @numbers;
        my $last  = shift @numbers;

        if ( any { $first <= $_->[1] and $last >= $_->[0] } @sets ) {
            # This interval intersects with a previous one
            push @match, [ $first, $last ];
        }
        # Add this interval to a list of previous intervals
        push @sets, [ $first, $last ];
    }

    say '[ ', join( ', ', map { "($_->[0],$_->[1])" } @match ), ' ]';
}

main(@ARGV);
