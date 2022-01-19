#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-146/
# TASK #1 > 10001st Prime Number
#
# Write a script to generate the 10001st prime number.

use strict;
use warnings;
use feature 'say';

my $n = 1;
my $count = 0;

do {} until (is_prime(++$n) && ++$count == 10001 && print $n);

sub is_prime {
    my $n = shift;
    #every composite number has a prime factor less than or equal to its square root.
    return 1 == grep {$n % $_ == 0} (1 .. sqrt $n);
}

__END__

$ time ./ch-1.pl
104743
real    0m2.137s
user    0m2.106s
sys     0m0.030s
