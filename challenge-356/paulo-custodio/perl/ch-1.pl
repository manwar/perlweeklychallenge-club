#!/usr/bin/env perl

# Challenge 356
#
# Task 1: Kolakoski Sequence
# Submitted by: Mohammad Sajid Anwar
# You are given an integer, $int > 3.
#
# Write a script to generate the Kolakoski Sequence of given length $int and return the count of 1 in the generated sequence. Please follow the wikipedia page for more informations.
#
# Example 1
# Input: $int = 4
# Output: 2
#
# (1)(22)(11)(2) => 1221
#
# Example 2
# Input: $int = 5
# Output: 3
#
# (1)(22)(11)(2)(1) => 12211
#
# Example 3
# Input: $int = 6
# Output: 3
#
# (1)(22)(11)(2)(1)(22) => 122112
#
# Example 4
# Input: $int = 7
# Output: 4
#
# (1)(22)(11)(2)(1)(22)(1) => 1221121
#
# Example 5
# Input: $int = 8
# Output: 4
#
# (1)(22)(11)(2)(1)(22)(1)(22) => 12211212

use Modern::Perl;
use Data::Dump 'dump';

sub kolakoski {
    my($n) = @_;
    my @seq = (1, 2, 2);
    my @count = (1, 2);
    for my $i (3 .. $n) {
        my $count = $seq[$i-1];
        my $num = 3 - $seq[-1];
        push @seq, ($num) x $count;
        push @count, $count;
    }
    return @count;
}

sub count_ones {
    my(@count) = @_;
    return scalar grep {$_==1} @count;
}

@ARGV==1 or die "Usage: $0 N\n";
my $N = 0+shift;
say count_ones(kolakoski($N));
