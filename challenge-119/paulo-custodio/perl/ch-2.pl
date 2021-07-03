#!/usr/bin/env perl

# Challenge 119
#
# TASK #2 - Sequence without 1-on-1
# Submitted by: Cheok-Yin Fung
# Write a script to generate sequence starting at 1. Consider the increasing
# sequence of integers which contain only 1’s, 2’s and 3’s, and do not have any
# doublets of 1’s like below. Please accept a positive integer $N and print the
# $Nth term in the generated sequence.
#
# 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131,
#
# Example
# Input: $N = 5
# Output: 13
#
# Input: $N = 10
# Output: 32
#
# Input: $N = 60
# Output: 2223

use Modern::Perl;

sub next_seq {
    state $n = 0;
    while (1) {
        $n++;
        return $n if $n =~ /^[123]+$/ && $n !~ /11/;
    }
}

my $N = shift // 1;
my $n;
$n = next_seq() for 1 .. $N;
say $n;
