#!/usr/bin/perl
# The Weekly Challenge 171
# Task 1 Abundant (Odd) Number
use v5.30.0;
use warnings;
use Math::Prime::Util qw/divisor_sum/;

my $N = $ARGV[0] || 20;
my @abunt;
my $n = 9;

while (scalar @abunt < $N) {
    $n += 2;
    if (divisor_sum($n) > 2*$n) {
        say $n;
        push @abunt, $n;
    }
}
