#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($str) {
    # Make sure we have valid input
    if ( $str !~ /^[a-z]+$/ ) {
        die "Invalid input\n";
    }

    # Start with the time it takes to press each key
    my $seconds = length($str);

    # Get the position of each character, and prepend an 'a' (0) to the list
    my @positions = map { ord($_) - ord('a') } split //, $str;
    unshift( @positions, 0 );

    foreach my $i ( 1 .. $#positions ) {
        # Work out the shortest way to move between the two characters
        my $diff = abs( $positions[ $i - 1 ] - $positions[$i] );
        if ( $diff > 13 ) {
            $diff = 26 - $diff;
        }

        # Add this time to the seconds value
        $seconds += $diff;
    }

    say $seconds;
}

main( $ARGV[0] );