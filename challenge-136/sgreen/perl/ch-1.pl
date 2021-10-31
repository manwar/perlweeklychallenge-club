#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'min';

sub _gcd {
    # Calculate the greatest common divisor. Start at the lowest of
    #   the two supplied numbers
    my ( $n1, $n2 ) = @_;

    # And work backwards until we find the gcd
    for ( my $i = min( $n1, $n2 ) ; $i >= 1 ; $i-- ) {
        return $i if $n1 % $i == 0 and $n2 % $i == 0;
    }

    # We should never get here, since when $i is one, the equation should
    #  always be true
    return 1;
}

sub _is_pot {
    # Returns whether the number is a power of two.
    my $n = shift;

    # Count upwards from 1 until we find a solution or go bust
    my $i = 0;

    while ( ++$i ) {
        my $p = 2**$i;
        return 1 if $p == $n;
        return 0 if $p > $n;
    }
}

sub main {
    my ( $m, $n ) = @_;

    # Sanity check
    die "You must specify two numbers\n"               unless defined $m and defined $n;
    die "The first value is not a positive integer\n"  unless $m =~ /^[1-9][0-9]*$/;
    die "The second value is not a positive integer\n" unless $n =~ /^[1-9][0-9]*$/;

    # Calculate the gcd
    my $gcd = _gcd( $m, $n );

    # .. and display whether it is a power of two
    say _is_pot($gcd);
}

main(@ARGV);
