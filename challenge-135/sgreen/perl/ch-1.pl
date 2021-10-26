#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $n = shift;

    # Check the input is valid
    die "You must enter an integer\n"               unless $n;
    die "The input does not look like an integer\n" unless $n =~ /^-?[1-9][0-9]*$/;

    # If it's a negative number, treat it like a positive from now onwards
    $n = abs($n);
    my $l = length( $n // '' );
    die "even numbers of digits\n" unless $l % 2 == 1;
    die "too short\n"              unless $l >= 3;

    # Display the middle three digits
    say substr( $n, ( $l - 3 ) / 2, 3 );
}

main(@ARGV);
