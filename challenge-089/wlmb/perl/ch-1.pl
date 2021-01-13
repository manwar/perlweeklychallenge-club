#!/usr/bin/env perl
# Perl weekly challenge 89
# Challenge 1.
# Given $N, calculate the sum of the greatest common divisors of all
# unique pairs of numbers between 1 and $N

# Load packages
use warnings;
use strict;
use v5.10;
use List::Util qw(sum0);

# I use a straight forward approach
# First I define a recursive function for the gcd using Euclid's algorithm
sub gcd {
    # I assume that both arguments are non-negative
    my ($a, $b)=@_;
    return $a if $b==0;
    return gcd($b, $a%$b);
}
# Now I generate recursively all unique pairs of numbers between $n
# and $m
sub pairs {
    # I assume both arguments are integer and different
    my ($n, $m)=@_;
    return () if $n>=$m; #no more pairs
    return ((map {[$n,$_]} ($n+1..$m)),  #pairs starting in $n
	    pairs($n+1, $m));          # and the rest
}
sub sumgcd { # sum gcd for all pairs
    # I assume $N is a positive integer
    my $N=shift;
    sum0 map {gcd($_->[0], $_->[1])} pairs(1,$N);
}

# Test a few cases:
say join " ", map {sumgcd($_)} (2..20);
# Answer:
# 1 3 7 11 20 26 38 50 67 77 105 117 142 172 204 220 265 283 335
