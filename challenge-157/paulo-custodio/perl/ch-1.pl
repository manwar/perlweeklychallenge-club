#!/usr/bin/env perl

# Challenge 157
#
# TASK #1 › Pythagorean Means
# Submitted by: Mohammad S Anwar
# You are given a set of integers.
#
# Write a script to compute all three Pythagorean Means i.e Arithmetic Mean,
# Geometric Mean and Harmonic Mean of the given set of integers. Please refer
# to wikipedia page for more informations.
#
# Example 1:
# Input: @n = (1,3,5,6,9)
# Output: AM = 4.8, GM = 3.8, HM = 2.8
# CORRECTION [2022-03-21 16:35] GM = 3.9 (before)
#
# Example 2:
# Input: @n = (2,4,6,8,10)
# Output: AM = 6.0, GM = 5.2, HM = 4.4
# Example 3:
# Input: @n = (1,2,3,4,5)
# Output: AM = 3.0, GM = 2.6, HM = 2.2

use Modern::Perl;
use List::Util qw( sum product );

my @n = @ARGV or die "Usage: ch-1.pl n...\n";
say "AM = ", f(am(@n)), ", GM = ", f(gm(@n)), ", HM = ", f(hm(@n));

sub am {
    my(@n) = @_;
    return sum(@n)/scalar(@n);
}

sub gm {
    my(@n) = @_;
    my $base = abs(product(@n));
    my $exp = 1/scalar(@n);
    return $base ** $exp;
}

sub hm {
    my(@n) = @_;
    my @invn = map {1/$_} @n;
    return scalar(@invn)/sum(@invn);
}

sub f {
    my($n) = @_;
    return sprintf("%.1f", $n);
}
