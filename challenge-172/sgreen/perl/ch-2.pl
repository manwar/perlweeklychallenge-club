#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub get_value ( $l, $quart ) {
    # Calculate the position of the value we require
    my $pos = ($#$l) * $quart / 100;
    my $i   = int($pos);

    if ( $i == $pos ) {
        # It is a single value
        return $l->[$i];
    }

    # We need the average of two numbers
    return ( $l->[$i] + $l->[ $i + 1 ] ) / 2;
}

sub main (@l) {
    # Sort the list
    @l = sort { $a <=> $b } @l;
    my @solution = ();

    # Calculate the five values
    foreach my $quart ( 0, 25, 50, 75, 100 ) {
        push @solution, get_value( \@l, $quart );
    }

    say join ', ', @solution;
}

main(@ARGV);
