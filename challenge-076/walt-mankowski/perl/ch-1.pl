#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use List::Util qw(sum);
use Algorithm::Combinatorics qw(combinations_with_repetition);

# TASK #1 › Prime Sum
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
#
# You are given a number $N. Write a script to find the minimum number
# of prime numbers required, whose summation gives you $N.
#
# For the sake of this task, please assume 1 is not a prime number.
# Example:
#
# Input:
#     $N = 9
#
# Ouput:
#     2 as sum of 2 prime numbers i.e. 2 and 7 is same as the input number.
#     2 + 7 = 9.

# compute primes up to $n using the Sieve of Eratosthenes
sub primes_upto($n) {
    my @is_prime = map {1} (0..$n);
    $is_prime[0] = $is_prime[1] = 0;

    for my $i (2..$n) {
        if ($is_prime[$i]) {
            for (my $j = $i * 2; $j <= $n; $j += $i) {
                $is_prime[$j] = 0;
            }
        }
    }
    return grep {$is_prime[$_]} 2..$n;
}

# find n possibly repeating primes, where n <= k, where the primes add
# up to s
sub sums_goldbach($s, $k, @primes) {
    my @solutions;
    my $best = 1e300;

    my $iter = combinations_with_repetition([0, @primes], $k);
    while (my $p = $iter->next) {
        my @digits = grep(!/^0$/, $p->@*); # remove 0s
        next unless @digits; # ignore (0,0,0)
        next unless sum(@digits) == $s;
        if (@digits < $best) {
            @solutions = (join " + ", @digits);
            $best = @digits;
        } elsif (@digits == $best) {
            push @solutions, join " + ", @digits;
        }
    }
    return @solutions;
}

my $n = shift @ARGV;
my @primes = primes_upto($n);
say "primes: @primes";

my $k = $n % 2 == 0 ? 2 : 3;
my @solutions = sums_goldbach($n, $k, @primes);
say join "\n", @solutions;
