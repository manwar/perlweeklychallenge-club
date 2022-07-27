#!/usr/bin/env perl
use v5.36;

# Task 2: Perfect Totient Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Perfect Totient Numbers.

sub gcd($a, $b) {
    return $b ? gcd($b, $a % $b) : $a;
}

my @totient = (0,0);
my $MAX = 6000;
for my $n (2..$MAX) {
    for my $i (1..$n-1) {
        $totient[$n]++ if gcd($n, $i) == 1;
    }
}

for my $i (2..$MAX) {
    my $tot = $totient[$i];
    my $sum = $tot;
    while ($tot != 1) {
        last if $sum > $i;
        $tot = $totient[$tot];
        $sum += $tot;
    }
    say $i if $sum == $i;
}
