#!/usr/bin/perl

# Challenge 076
#
# TASK #1 › Prime Sum
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
# You are given a number $N. Write a script to find the minimum number of prime numbers required, whose summation gives you $N.
#
# For the sake of this task, please assume 1 is not a prime number.
#
# Example:
# Input:
#     $N = 9
#
# Ouput:
#     2 as sum of 2 prime numbers i.e. 2 and 7 is same as the input number.
#     2 + 7 = 9.

use strict;
use warnings;
use 5.030;
use Math::Combinatorics;

my($N) = shift;

my @solution = find_set($N);
if (@solution) {
    say join(" + ", sort @solution)." = $N";
}
else {
    die "no solution found for $N\n";
}


# check if number is prime
sub is_prime {
    my($n) = @_;

    return 0 if $n <= 1;
    return 1 if $n <= 3;

    return 0 if ($n % 2)==0 || ($n % 3)==0;

    for (my $i = 5; $i*$i <= $n; $i += 6) {
        return 0 if ($n % $i)==0 || ($n % ($i+2))==0;
    }

    return 1;
}

# next prime
sub next_prime {
    my($n) = @_;

    return 2 if $n <= 1;
    my $p = $n;
    1 while !is_prime(++$p);
    return $p;
}

# get all primes up to N
sub primes {
    my($n) = @_;
    my $p = 2;
    my @primes;
    while ($p <= $n) {
        push @primes, $p;
        $p = next_prime($p);
    }
    return @primes;
}

# check all combinations for the shortest that adds up to N
sub find_set {
    my($n) = @_;

    # get all primes up to N, 1 not included;
    # append primes 2 and 3 to be able to solve special cases 4 and 6
    my @primes = (primes($n), 2, 3);

    my @solution;
    for my $k (1 .. scalar(@primes)) {
        my $combinat = Math::Combinatorics->new(count => $k, data => \@primes);
        while(my @set = $combinat->next_combination) {
            if (sum(@set) == $n) {
                if (!@solution || @solution > @set) {
                    @solution = @set;
                    return @solution if @solution == 1;
                }
            }
        }
    }
    return @solution;
}

sub sum {
    my($sum, @a) = @_;
    $sum += $_ for @a;
    return $sum;
}
