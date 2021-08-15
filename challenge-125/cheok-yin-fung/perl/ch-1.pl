#!/usr/bin/perl
# The Weekly Challenge 125
# Task 1: Pythagorean Triples
# Usage: ch-1.pl $n
use strict;
use warnings;
use v5.10.0;
use experimental 'signatures';
use List::Util qw/max/;
use Test::More tests => 8;

my $num = $ARGV[0] || 5;
my @arr = pyth($num)->@*;

if (scalar @arr > 0) {
    say "(",join(", ", $_->@*),")" foreach(@arr);
}
else {
    say "-1";
}



sub pyth ($n) {
    my @ans;
    for my $a (1..int $n/sqrt(2) ) {
        my $is_sq = $n*$n-$a*$a;
        if (sqrt($is_sq) == int sqrt($is_sq)) {
            push @ans, [$a, sqrt($is_sq), $n];
        }
    }

    for my $a0 (1..$n-1) {
        my $is_sq = $a0*$a0 + $n*$n;
        if (sqrt($is_sq) == int sqrt($is_sq)) {
            push @ans, [$a0, $n, sqrt($is_sq)];
        }
    }


    # (C+1)^2 - C^2 = 2C + 1
    # 2C + 1 <= n^2
    # C <= (n^2-1)/2

    for my $b0 ($n+1..int ($n*$n-1)/2) {
        my $is_sq = $b0*$b0 + $n*$n;
        if (sqrt($is_sq) == int sqrt($is_sq)) {
            push @ans, [$n , $b0 ,sqrt($is_sq)];
        }
    }

    return \@ans;
}


ok scalar @{pyth(1)} == 0, "Number 1";
ok scalar @{pyth(2)} == 0, "Number 2";
ok scalar @{pyth(3)} == 1, "Number 3";
ok scalar @{pyth(4)} == 1, "Number 4";
ok scalar @{pyth(5)} == 2, "Number 5";
ok scalar @{pyth(8)} == 2, "Number 8";
ok scalar @{pyth(13)} == 2, "Number 13";
ok scalar @{pyth(5740)} == 44, "Number 5740"  # oeis.org/A046081
