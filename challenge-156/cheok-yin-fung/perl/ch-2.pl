#!/usr/bin/perl
# The Weekly Challenge 156
# Task 2 Weird Number 
# references on subset sum:
# https://www.geeksforgeeks.org/subset-sum-problem-dp-25/
# Usage: $ ch-2.pl $N

use v5.22.0;
use warnings;
use List::Util qw/uniqint sum/;
use Math::Prime::Util qw/next_prime/;

if (defined($ARGV[0])) {
    my $N = $ARGV[0];
    say(weird($N) ? "$N is a weird number." : "$N is not weird.");
}



sub weird {
    my $num = $_[0];
    return 0 if $num == 1;
    my @proper_divisors = proper_divisors($num);
    return 0 if (sum @proper_divisors) < $num;
    return !subset_sum($num, [@proper_divisors]);
}



sub factorization {
    # trivial prime factorization
    my $num = $_[0];
    my @prime_factors;
    my $prime = 2;
    while ($num != 1) {
        if ($num % $prime == 0) {
            $num /= $prime;
            push @prime_factors, $prime;
        }
        else {
            $prime = next_prime($prime);
        }
    }
    return @prime_factors;
}



sub proper_divisors {
    my @prime_factors = factorization($_[0]);
    my @pd = (1);
    while (scalar @prime_factors > 0) {
        my $n = shift @prime_factors;
        my @temp_pd = @pd;
        push @pd, $n*$_ for @temp_pd;
    }
    @pd = sort {$a<=>$b} uniqint @pd;
    pop @pd;    # remove the largest factor -> the number itself
    return @pd;
}



sub subset_sum {
    # dynamic programming
    my $sum = $_[0];
    my @A = $_[1]->@*;

    my $DP;
    $DP->[0][$_] = 1 for (0..scalar @A);
    $DP->[$_][0] = undef for (1..$sum);
    for my $s (1..$sum) {
        for my $k (1..scalar @A) {
            $DP->[$s][$k] = $DP->[$s][$k-1];
            if ($s >= $A[$k-1]) {
                $DP->[$s][$k] = $DP->[$s][$k]
                                    ||
                              $DP->[$s-$A[$k-1]][$k-1];
            }
        }
    }
    return $DP->[$sum][scalar @A];
}



use Test::More tests => 6;
ok !weird(12), "n=12 (Example 1)";
ok weird(70), "n=70 (Example 2)";
ok !weird(100), "n=100";
ok weird(4030), "n=4030 (term from wikipedia)";
ok !weird(6000), "n=6000";
ok weird(9272), "n=9272 (term from wikipedia)";
