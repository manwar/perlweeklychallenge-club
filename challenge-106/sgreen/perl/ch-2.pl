#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _div {
    # Hacky long division short cut. Returns the integer division of
    # $i ÷ $j, and the remainder × 10.
    my ( $i, $j ) = @_;
    my $x = int( $i / $j );
    return ( $x, ( $i - $x * $j ) * 10 );
}

sub main {
    my ( $N, $D ) = @_;

    # Sanity checks
    die "You must enter two numbers\n"                      if not defined $D;
    die "The value '$N' does not appear to be an integer\n" if $N !~ /^-?\d+$/;
    die "The value '$D' does not appear to be an integer\n" if $D !~ /^-?\d+$/;

    # Let's deal with the whole part of the number first
    ( my $whole, $N ) = _div( $N, $D );

    my $digits = '';
    my %seen   = ();
    while ( $N != 0 and not exists $seen{$N} ) {
        # Repeat the division until we've seen a remainder
        $seen{$N} = length($digits);
        ( my $digit, $N ) = _div( $N, $D );
        $digits .= $digit;
    }

    if ( $N == 0 ) {
        # It's not a repeating number
        say $digits ? "$whole.$digits" : $whole;
    }
    else {
        # Add the parenthesis in the correct place, and display the number
        substr( $digits, $seen{$N}, 0, '(' );
        say "$whole.$digits)";
    }
}

main(@ARGV);
