#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

sub _is_self_descriptive {
    my $n = shift;
    my $l = length($n) - 1;

    # Get a count of each character
    my @char = (0) x 10;
    ++$char[ substr( $n, $_, 1 ) ] foreach ( 0 .. $l );

    foreach my $pos ( 0 .. $l ) {
        # See how many characters we expect
        my $expect = substr( $n, $pos, 1 );

        # Exit if the numbers don't match
        return if $expect != $char[$pos];
    }

    # It's a self descriptive number
    return 1;
}

sub main {
    my @numbers = ();
    my $number  = 0;

    while ( ++$number and @numbers < 3 ) {
        if ( _is_self_descriptive($number) ) {
            push @numbers, $number;
        }
    }

    say join ', ', @numbers;
}

main();
