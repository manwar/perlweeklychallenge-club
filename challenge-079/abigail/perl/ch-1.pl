#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

#
# Challenge:
#
#   You are given a positive number $N.
#
#   Write a script to count the total numbrer of set bits of the binary
#   representations of all numbers from 1 to $N and return
#   $total_count_set_bit % 1000000007.
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
#

#
# This is A000778 (https://oeis.org/A000788). There's a recursive formala
# for the number of bits in the binary representation of 0 .. $N:
#
#    bits (0) = 0
#    bits (2 * N)     =     bits (N) + bits (N - 1) + N
#    bits (2 * N + 1) = 2 * bits (N)                + N + 1
#

use experimental 'signatures';
use experimental 'lexical_subs';

use integer;

my $BIG_NUM = 1_000_000_007;

sub bits ($n) {
    state $bits;
    $$bits {$n} ||= 
        $n == 0 ? 0
      : do {
            my $half = int ($n / 2);
            bits ($half) + $half + ($n % 2 ? bits ($half) + 1
                                           : bits ($half - 1))
      }
}

say bits (<>) % $BIG_NUM;


__END__
