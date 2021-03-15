#!/usr/bin/env perl

# Challenge 022
#
# Task #1
# Write a script to print first 10 Sexy Prime Pairs. Sexy primes are prime
# numbers that differ from each other by 6. For example, the numbers 5 and 11
# are both sexy primes, because 11 - 5 = 6. The term “sexy prime” is a pun
# stemming from the Latin word for six: sex. For more information, please
# checkout wiki page.

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

# sexy primes
sub sexy_primes_iter {
    my $a = 1;
    return sub {
        while (1) {
            $a = next_prime($a);
            my $b = $a;
            $b = next_prime($b) while $b < $a+6;
            return ($a, $b) if $b == $a+6;
        }
    };
}

my $iter = sexy_primes_iter();
for (1..10) {
    my($a, $b) = $iter->();
    say "($a, $b)";
}
