#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use List::Util qw(sum);

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

sub value($c, $cnt) {
    my $sum = 0;
    for my $i (0..$#$c) {
        $sum += $c->[$i] * $cnt->[$i];
    }
    return $sum;
}

sub sums($s, @c) {
    my @solutions;

    my @cnt = map {0} 0..$#c;
    while (1) {
        my $val = value(\@c, \@cnt);
        if ($val >= $s) {
            if ($val == $s) {
                my @tmp = @cnt;
                push @solutions, \@tmp;
            }

            # rotate "odometer"
            $cnt[-1] = 0;
            my $i = -2;
            $cnt[$i]++;
            while ($i >= -@c && value(\@c, \@cnt) > $s) {
                $cnt[$i] = 0;
                $i--;
                $cnt[$i]++ if $i >= -@c;
            }
            last if $i < -@c;
        } else {
            $cnt[-1]++;
        }
    }
    return @solutions;
}

my $n = shift @ARGV;
my @primes = primes_upto($n);
my @solutions = sums($n, @primes);
say "primes: @primes";

# find indices of best solution
my $min = 1e300;
my @best;
for my $i (0..$#solutions) {
    my $sum = sum $solutions[$i]->@*;
    if ($sum < $min) {
        $min = $sum;
        @best = ($i);
    } elsif ($sum == $min) {
        push @best, $i;
    }
}

# print out the solutions
for my $i (@best) {
    my @p;
    for my $j (0..$#primes) {
        push @p, ($primes[$j]) x $solutions[$i][$j] if $solutions[$i][$j];
    }
    say join " + ", @p;
}
