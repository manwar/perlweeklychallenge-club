#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'max';

sub collect_coins (@coins) {
    # If we only have one coin left, use that
    if ( $#coins == 0 ) {
        return $coins[0];
    }

    my @collections = ();

    foreach my $i ( 0 .. $#coins ) {
        # Work out how many coins we collect when we remove this coin
        my $collect = $coins[$i];
        if ( $i > 0 ) {
            $collect *= $coins[ $i - 1 ];
        }
        if ( $i < $#coins ) {
            $collect *= $coins[ $i + 1 ];
        }

        # Create a new list without this coin
        my @new_coins = @coins;
        splice( @new_coins, $i, 1 );
        # ... and call the function again
        $collect += collect_coins(@new_coins);

        push @collections, $collect;
    }

    # Return the best score
    return max(@collections);
}

sub main (@coins) {
    say collect_coins(@coins);
}

main(@ARGV);