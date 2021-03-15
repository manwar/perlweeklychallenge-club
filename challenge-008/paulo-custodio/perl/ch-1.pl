#!/usr/bin/perl

# Challenge 008
#
# Challenge #1
# Write a script that computes the first five perfect numbers. A perfect number
# is an integer that is the sum of its positive proper divisors (all divisors
# except itself). Please check Wiki for more information. This challenge was
# proposed by Laurent Rosenfeld.

use strict;
use warnings;
use 5.030;

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

# Euclid proved that 2^(p−1)*(2^p − 1) is an even perfect number
# whenever 2p − 1 is prime
sub perfect_iter {
    my $p = 1;
    return sub {
        while (1) {
            $p = next_prime($p);    # next prime number
            my $f = (2**$p)-1;
            return (2**($p-1))*$f if is_prime($f);
        }
    };
}


# main
my $n = shift || 5;
my $iter = perfect_iter();
for (1..$n) {
    say $iter->();
}
