#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'sum';

sub is_prime($n) {
    # Determine if the given integer is a prime
    foreach my $i ( 2 .. sqrt($n) ) {
        if ( $n % $i == 0 ) {
            return 0;
        }
    }

    # One isn't a prime
    return $n >= 2 ? 1 : 0;
}

sub main ($word) {
    # Check the input is valid
    if ( not $word =~ /^[A-Za-z]+$/ ) {
        die "Input can only contain English letters\n";
    }

    # Calculate the sum of all the letters
    my $target = sum( map { ord($_) } split //, $word );

    # Check if this is a prime number
    if ( is_prime($target) ) {
        say 0;
        return;
    }

    my $diff = 1;
    while (1) {
        # Check if the number diff less than or greater than the target is a
        #  prime
        if ( is_prime( $target - $diff ) or is_prime( $target + $diff ) ) {
            say $diff;
            return;
        }
        $diff++;
    }
}

main(@ARGV);
