#!/usr/bin/env perl
use v5.36;
use List::Util qw(sum);

# Task 1: Abundant Number
#
# Write a script to generate first 20 Abundant Odd Numbers.
#
# According to wikipedia,
#
#     A number n for which the sum of divisors σ(n) > 2n, or,
#     equivalently, the sum of proper divisors (or aliquot sum) s(n) >
#     n.
#
# For example, 945 is the first Abundant Odd Number.
#
# Sum of divisors:
# 1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975

sub odd_divisors($n) {
    my @od = (1);
    my $max = $n / 2;
    for (my $i = 3; $i <= $max; $i += 2) {
        push @od, $i if $n % $i == 0;
    }
    return @od;
}

my @abundant;
my $n = 1;
while (@abundant < 20) {
    my @od = odd_divisors($n);
    if (sum(@od) > $n) {
        push @abundant, $n;
        printf "%2d: %s = %d\n", scalar @abundant, join(" + ", @od), sum(@od);
    }
    $n += 2;
}
$, = " ";
say @abundant;
