#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Check we an even number of items
    if ( $#ints % 2 == 0 ) {
        die "Please provide an even number of items!\n";
    }

    # Split the list in to two
    my $half = scalar(@ints) / 2;
    my @x    = @ints[ 0 .. $half - 1 ];
    my @y    = @ints[ $half .. $#ints ];

    # Sort the lists
    @x = sort { $a <=> $b } @x;
    @y = sort { $a <=> $b } @y;

    # Calculate the difference between the first values
    my $diff = $y[0] - $x[0];

    foreach my $i ( 0 .. $#x ) {
        if ( $y[$i] - $x[$i] != $diff ) {
            # There is no single magic number
            say 'No magic number found!';
            return;
        }
    }

    # Return the magic number
    say $diff;
}

main(@ARGV);