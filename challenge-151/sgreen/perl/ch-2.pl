#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'max';

sub rob {
    my ( $haul, $valuables ) = @_;
    if ( @{$valuables} <= 2 ) {
        # We rob the remaining house, and take off with the haul!
        return $haul + $valuables->[0];
    }

    # Call the function recursively skipping either one or two houses
    my @hauls = ();
    push @hauls, rob( $haul + $valuables->[0], [ @{$valuables}[ 2 .. $#$valuables ] ] );
    if ( @{$valuables} >= 4 ) {
        push @hauls, rob( $haul + $valuables->[0], [ @{$valuables}[ 3 .. $#$valuables ] ] );
    }

    # Return the largest haul
    return max(@hauls);
}

sub main {
    my @valuables    = @_;
    my $largest_haul = rob( 0, \@valuables );
    say $largest_haul;
}

main(@ARGV);