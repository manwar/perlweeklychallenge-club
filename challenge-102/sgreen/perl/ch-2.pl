#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $length = shift;

    # Sanity check
    die "You must specify a number\n" if not defined $length;
    die "The number is not a positive integer\n" unless $length =~ /^[1-9][0-9]*$/;

    my $string   = '#' x $length;
    my $position = $length - 1;     # The last character

    while ( $position - length( $position + 1 ) >= 0 ) {
        my $char = length( $position + 1 );
        substr( $string, $position - $char, $char, $position + 1 );
        $position -= ( $char + 1 );
    }

    say $string;
}

main(@ARGV);
