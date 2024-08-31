#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/
# TASK #1 > Unique Number
#
# You are given an array of integers, @ints, where every elements appears more than once except one element.
#
# Write a script to find the one element that appears exactly one time.
#
# Example 1
# Input: @ints = (3, 3, 1)
# Output: 1
# Example 2
# Input: @ints = (3, 2, 4, 2, 4)
# Output: 3
# Example 3
# Input: @ints = (1)
# Output: 1
# Example 4
# Input: @ints = (4, 3, 1, 1, 1, 4)
# Output: 3

use strict;
use warnings;
use feature 'say';

my @ints = @ARGV;
my %seen;
$seen{$_}++ for @ints;

say grep { $seen{$_} == 1 } @ints;

__END__

$ ./ch-1.pl 3 1 1 3 5 2 4 2 4
5
