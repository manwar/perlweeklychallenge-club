#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-158/
# Task #2 > First Series Cuban Primes
#
# Write a script to compute first series Cuban Primes <= 1000.
#
# Please refer wikipedia page for more informations.
# https://en.wikipedia.org/wiki/Cuban_prime
#
# Output
# 7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919.

use strict;
use warnings;
use feature 'say';

my $y = 0;
my @cuban;

while (++$y) {
    my $n = 3*$y**2+3*$y+1;
    last if $n > 1000;
    push @cuban, $n if is_prime($n);
}

say join ', ', @cuban;

sub is_prime {
    my $n = shift;
    #every composite number has a prime factor less than or equal to its square root.
    return 1 == grep {$n % $_ == 0} (1 .. sqrt $n);
}

__END__

$ ./ch-2.pl
7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919
