#!/usr/bin/perl

# Challenge 198
#
# Task 2: Prime Count
# Submitted by: Mohammad S Anwar
# You are given an integer $n > 0.
#
# Write a script to print the count of primes less than $n.
#
# Example 1
# Input: $n = 10
# Output: 4 as in there are 4 primes less than 10 are 2, 3, 5 ,7.
# Example 2
# Input: $n = 15
# Output: 6
# Example 3
# Input: $n = 1
# Output: 0
# Example 4
# Input: $n = 25
# Output: 9

use Modern::Perl;

# https://en.wikipedia.org/wiki/Primality_test
sub is_prime {
    my($n) = @_;
    return 1 if $n == 2 || $n == 3;
    return 0 if $n <= 1 || $n % 2 == 0 || $n % 3 == 0;
    for (my $i = 5; $i * $i <= $n; $i += 6) {
        return 0 if $n % $i == 0 || $n % ($i + 2) == 0;
    }
    return 1;
}

sub next_prime {
    my($p) = @_;
    $p++;
    $p++ while !is_prime($p);
    return $p;
}

sub count_primes_below_n {
    my($n) = @_;
    my $count=0;
    my $p=2;
    while ($p<$n) {
        $count++;
        $p=next_prime($p);
    }
    return $count;
}

@ARGV==1 or die "usage: solve.pl limit\n";
my $limit = shift;
say count_primes_below_n($limit);
