#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-022/
# Task #1
# Write a script to print first 10 Sexy Prime Pairs. Sexy primes are prime numbers that differ from each other by 6.
# For example, the numbers 5 and 11 are both sexy primes, because 11 - 5 = 6.
# The term "sexy prime" is a pun stemming from the Latin word for six: sex.
# For more information, please checkout wiki page.
# https://en.wikipedia.org/wiki/Sexy_prime

use strict;
use warnings;

use constant LIMIT => 10;

my $n = 0;
my $pairs = 0;
my %primes;

do {{ # double block to allow next within do until
    next if (!is_prime(++$n));      # only primes allowed
    $primes{$n}=1;

    if(exists $primes{$n-6}) {
        print sprintf("(%d,%d)\n",$n-6,$n);
        $pairs++;
    }
}} until ($pairs == LIMIT);

sub is_prime {
    my $n = shift;
    return 0 if $n <= 1;
    #every composite number has a prime factor less than or equal to its square root.
    return 1 == grep {$n % $_ == 0} (1 .. sqrt $n);
}
