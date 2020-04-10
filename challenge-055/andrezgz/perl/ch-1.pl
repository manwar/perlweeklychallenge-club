#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-055/
# Task #1
#
# Flip Binary
# You are given a binary number B, consisting of N binary digits 0 or 1: s0, s1, ..., s(N-1).
#
# Choose two indices L and R such that 0 <= L <= R < N and flip the digits s(L), s(L+1), ..., s(R).
# By flipping, we mean change 0 to 1 and vice-versa.
#
# For example, given the binary number 010, the possible flip pair results are listed below:
#
# L=0, R=0 the result binary: 110
# L=0, R=1 the result binary: 100
# L=0, R=2 the result binary: 101
# L=1, R=1 the result binary: 000
# L=1, R=2 the result binary: 001
# L=2, R=2 the result binary: 011
# Write a script to find the indices (L,R) that results in a binary number with maximum number of 1s.
#  If you find more than one maximal pair L,R then print all of them.
#
# Continuing our example, note that we had three pairs (L=0, R=0), (L=0, R=2),
#  and (L=2, R=2) that resulted in a binary number with two 1s, which was the maximum.
# So we would print all three pairs.

use strict;
use warnings;

die "USAGE: $0 <binary-number>" unless @ARGV == 1 && $ARGV[0] =~ /^[01]+$/;

my $binary = shift;
my $d = (length $binary) - 1;

my $max = 0;
my @solution;

for my $l (0 .. $d) {
    my @digits = split //,$binary;
    for my $r ($l .. $d) {

        $digits[$r] = $digits[$r] ? 0 : 1; #invert

        my $ones = grep { $_ } @digits;
        next if $ones < $max;

        if ($ones > $max) {
            $max = $ones;
            @solution = { l => $l, r => $r };
        }
        else {
            push @solution, { l => $l, r => $r };
        }
    }
}

printf '(L=%d, R=%d)'.$/, $_->{l}, $_->{r} for @solution;

__END__

./ch-1.pl 010
(L=0, R=0)
(L=0, R=2)
(L=2, R=2)

./ch-1.pl 101
(L=1, R=1)

./ch-1.pl 010
(L=0, R=0)
(L=0, R=2)
(L=2, R=2)
