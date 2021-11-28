#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'min';

sub main {
    my ( $i, $j, $k ) = @_;
    my @numbers = ();

    foreach my $m ( 1 .. $i ) {
        # Calculate the number of products required. If we already have
        #  $k values, then we only need to calculate values whose product
        #  is smaller, otherwise the lesser of $j or $k
        my $max = @numbers >= $k ? int( $numbers[ $k - 1 ] / $m ) : min( $j, $k );

        # Hack if the $i > $k[-1]
        last if $max == 0;

        # Add to the array, sort it, trim it
        push @numbers, map { $_ * $m } ( 1 .. $max );
        @numbers = sort { $a <=> $b } @numbers;
        splice( @numbers, $k );
    }

    say $numbers[-1];
}

main(@ARGV);
