#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-041/
# Task #1
# Write a script to display attractive number between 1 and 50.
# A number is an attractive number if the number of its prime factors is also prime number.
# The number 20 is an attractive number, whose prime factors are 2, 2 and 5.
# The total prime factors is 3 which is also a prime number.

use strict;
use warnings;

my $upto = shift || 50;

foreach (1 .. $upto){
    print $_ . ' ' if is_prime( scalar prime_decomp($_) );
}


sub prime_decomp {
    my $n = shift;

    my @prime_decomp;

    foreach my $prime ( prime_factors($n) ){
        do {
            $n /= $prime;
            push @prime_decomp, $prime;
        } while ($n % $prime == 0);
    }

    return @prime_decomp;
}


sub prime_factors {
    my $n = shift;
    return if $n == 1;
    my @r = grep {$n % $_ == 0 && is_prime($_)} (2 .. $n/2); #get prime divisors
    return @r ? @r : ($n); # number is prime if no prime divisors were found
}

sub is_prime {
    my $n = shift;
    return if $n == 1;
    #every composite number has a prime factor less than or equal to its square root.
    return 1 == grep {$n % $_ == 0} (1 .. sqrt $n);
}

__END__

./ch-1.pl
4 6 8 9 10 12 14 15 18 20 21 22 25 26 27 28 30 32 33 34 35 38 39 42 44 45 46 48 49 50
