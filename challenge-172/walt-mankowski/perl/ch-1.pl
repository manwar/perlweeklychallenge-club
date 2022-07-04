#!/usr/bin/env perl
use v5.36;
use lib ".";
use Algorithm::Combinatorics qw(combinations);
use primes qw(primes_to);
use List::Util qw(sum);

# You are given two positive integers, $m and $n.
#
# Write a script to find out the Prime Partition of the given
# number. No duplicates allowed.
#
# For example,
#
# Input: $m = 18, $n = 2
# Output: 5, 13 or 7, 11
#
# Input: $m = 19, $n = 3
# Output: 3, 5, 11

$, = " ";
my ($m, $n) = @ARGV;
my $primes = primes_to($m);
my $iter = combinations($primes, $n);
while (my $p = $iter->next) {
    say $p->@* if sum($p->@*) == $m;
}
