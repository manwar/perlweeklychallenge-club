#!/usr/bin/env perl

# Challenge 023
#
# Task #2
# Create a script that prints Prime Decomposition of a given number. The prime
# decomposition of a number is defined as a list of prime numbers which when
# all multiplied together, are equal to that number. For example, the Prime decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.

use strict;
use warnings;
use 5.030;

my($n) = @ARGV;
say join(", ", prime_decomposition($n)), ".";


# check if number is prime
sub is_prime {
    my($n) = @_;

    return 0 if $n <= 1;
    return 1 if $n <= 3;

    return 0 if ($n % 2)==0 || ($n % 3)==0;

    for (my $i = 5; $i*$i <= $n; $i += 6) {
        return 0 if ($n % $i)==0 || ($n % ($i+2))==0;
    }

    return 1;
}

# next prime
sub next_prime {
    my($n) = @_;

    return 2 if $n <= 1;
    my $p = $n;
    1 while !is_prime(++$p);
    return $p;
}


sub prime_decomposition {
    my($n) = @_;
    return ($n) if $n <= 2;     # special cases

    my @f;                      # factors
    my $p = 2;                  # first prime
    while ($n > 1) {
        if ($n % $p == 0) {
            push @f, $p;
            $n /= $p;
        }
        else {
            $p = next_prime($p);
        }
    }

    return @f;
}
