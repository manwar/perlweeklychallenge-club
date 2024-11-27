#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(all any uniq);

sub is_boomerang($points) {
    # Check for a flat line (to avoid division by zero error)
    if ( all { $points->[0][1] == $points->[$_][1] } ( 1 .. $#{$points} ) ) {
        return 'false';
    }

    if ( any { $points->[0][1] == $points->[$_][1] } ( 1 .. $#{$points} ) ) {
        return 'true';
    }

    my @degrees = (
        map {
            abs( ( $points->[0][0] - $points->[$_][0] ) /
                  ( $points->[0][1] - $points->[$_][1] ) )
        } ( 1 .. $#$points )
    );

    if ( scalar( uniq @degrees ) == 1 ) {
        # All points are a straight line
        return 'false';
    }

    return 'true';
}

sub main (@ints) {
    my @points = ();
    for ( my $i = 0 ; $i <= $#ints ; $i += 2 ) {
        push @points, [ $ints[$i], $ints[ $i + 1 ] ];
    }
    my $result = is_boomerang( \@points );
    say $result;
}

main(@ARGV);
