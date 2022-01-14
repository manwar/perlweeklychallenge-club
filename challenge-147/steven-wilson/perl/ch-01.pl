#!/usr/bin/env perl
# Week 147 Task 1
# Truncatable Prime
# Write a script to generate first 20 left-truncatable prime numbers in base 10.

use strict;
use warnings;
use feature qw/ say /;
use Math::Prime::Util qw/ next_prime is_prime /;

my @ltp          = qw/ 2 /;
my $prime_number = 2;

while ( scalar @ltp < 20 ) {
    $prime_number = next_prime($prime_number);
    if ( is_truncatable_prime($prime_number) ) {
        push @ltp, $prime_number;
    }
}

sub is_truncatable_prime {
    my $prime_number   = shift;
    my $prime_number_m = $prime_number;
    my $truncatable    = 1;
    while ( length $prime_number_m > 0 ) {
        if ( $prime_number_m =~ /0/ ) {    # contains no 0
            $truncatable = 0;
            last;
        }
        if ( not is_prime($prime_number_m) ) {
            $truncatable = 0;
            last;
        }
        $prime_number_m =~ /^[0-9]{1}([0-9]*)/;
        $prime_number_m = $1;
    }
    return $truncatable;
}

say join " ", @ltp;
