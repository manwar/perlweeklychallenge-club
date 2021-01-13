#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/
# Task #1
#
# Diff-K
# You are given an array @N of positive integers (sorted) and another non negative integer k.
#
# Write a script to find if there exists 2 indices i and j such that A[i] - A[j] = k and i != j.
#
# It should print the pairs of indices, if any such pairs exist.
#
# Example:
#
#     @N = (2, 7, 9)
#     $k = 2
# Output : 2,1

use strict;
use warnings;

my $usage = "Usage: $0 <sum> <n1> <n2> ...\n";

my $k = shift or die $usage;
my @sorted = sort {$a <=> $b } @ARGV;
die $usage if @sorted < 2;

OUT: for my $i (reverse 0 .. @sorted - 1) {
    for my $j (reverse 0 .. $i-1) {
        next OUT if $sorted[$i] - $sorted[$j] > $k; #avoid checking further
        print "($i,$j)\n"  if $sorted[$i] - $sorted[$j] == $k;
    }
}

__END__

./ch-1.pl 2 2 7 9
(2,1)

./ch-1.pl 3 2 7 9 10 11 12
(5,2)
(3,1)
