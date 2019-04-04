#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-002/
# Challenge #1
# Write a script or one-liner to remove leading zeros from positive numbers.

# Wikipedia - https://en.wikipedia.org/wiki/Leading_zero
# A leading zero is any 0 digit that comes before the first nonzero digit
# in a number string in positional notation.
# When leading zeros occupy the most significant digits of an integer,
# they could be left blank or omitted for the same numeric value.
# Therefore, the usual decimal notation of integers does not use leading zeros
# except for the zero itself, which would be denoted as an empty string otherwise.

# Non-numeric data
# 0a     -> 0a
# a      -> a

# Non-positive numbers
# 0      -> 0
# 0.     -> 0.
# 0.0    -> 0.0
# 00     -> 00
# 00.    -> 00.
# 00.0   -> 00.0
# -01    -> -01
# -01.   -> -01.
# -01.0  -> -01.0

# Leading zeros on positive numbers
# 01     -> 1
# 01.    -> 1.
# 01.0   -> 1.0
# 010.0  -> 10.0

use strict;

my $number = @ARGV[0];

$number =~ s/^0+([1-9][0-9]*(:?[.,]\d*)?)$/$1/;
print $number;
