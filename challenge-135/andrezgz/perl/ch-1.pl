#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-135/
# TASK #1 > Middle 3-digits
#
# You are given an integer.
#
# Write a script find out the middle 3-digits of the given integer, if possible otherwise throw sensible error.
#
# Example 1
# Input: $n = 1234567
# Output: 345
# Example 2
# Input: $n = -123
# Output: 123
# Example 3
# Input: $n = 1
# Output: too short
# Example 4
# Input: $n = 10
# Output: even number of digits

use strict;
use warnings;
use feature 'say';

my $n = shift;
die "not an integer\n" if !$n || $n !~ /^-?\d+$/;

$n *= -1 if $n < 0;
my $l = length $n;

die "even number of digits\n" if $l % 2 == 0;
die "too short\n" if $l < 3;

my $m = int($l/2) - 1;
say substr $n, $m, 3;

__END__

./ch-1.pl 1234567
345

./ch-1.pl -123
123

./ch-1.pl 1
too short

./ch-1.pl 10
even number of digits
