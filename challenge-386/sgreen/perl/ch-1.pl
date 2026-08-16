#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'any';

sub main ( $str, $base ) {
    # Truncate the alphabet to the correct base
    my $alphabet = substr(
        "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghijklmnopqrstuvwxyz+/",
        0, $base );

    my @digits = map { index( $alphabet, $_ ) } split //, $str;

    if ( any { $_ == -1 } @digits ) {
        die "Invalid input for the specified base\n";
    }

    # Calculate the base-10 integer
    my $output = 0;
    foreach my $digit (@digits) {
        $output *= $base;
        $output += $digit;
    }
    say $output;
}

main(@ARGV);
