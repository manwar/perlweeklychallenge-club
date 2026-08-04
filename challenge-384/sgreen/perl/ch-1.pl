#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($num, $base) {
    if ($base < 2 or $base > 64) {
        die "Invalid base value: $base\n";
    }
    if ($num < 0) {
        die "Number $num must be non-negative\n";
    }

    # Convert the number into digits in the specified base
        # Convert the number into digits in the specified base
    my @digits = ();
    while (1) {
        my $i = int( $num / $base );
        my $j = $num % $base;
        unshift @digits, $j;

        if ( $i == 0 ) {
            last;
        }

        $num = $i;
    }

    # The string representation of 64 digits
    my $alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/";

    # Return the string representation of the digits
    say join("", map { substr($alphabet, $_, 1) } @digits);
}

main(@ARGV);