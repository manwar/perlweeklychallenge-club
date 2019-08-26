#!/usr/bin/env perl
#
# Write a script to print first 10 Sexy Prime Pairs. Sexy primes are prime
# numbers that differ from each other by 6. For example, the numbers 5 and 11
# are both sexy primes, because 11 - 5 = 6. The term “sexy prime” is a pun
# stemming from the Latin word for six: sex. For more information, please
# checkout wiki page.
#
# (https://en.wikipedia.org/wiki/Sexy_prime).
################################################################################

use strict;
use warnings;

use List::Util qw<any>;

my $MAX_SEXY = 10;

my @primes = ();
my @sexy;
my $p = 2;

while (@sexy < $MAX_SEXY*2) {
    unless (any { $p % $_ == 0 } @primes) {
        push @primes, $p;
        push @sexy, $primes[-2], $primes[-1]
            if @primes > 1 && $primes[-1] == $primes[-2] + 6;
    }
    $p++;
}

foreach my $i (0 .. @sexy/2-1) {
    printf "%s-%s\n", $sexy[$i*2], $sexy[$i*2+1];
}
