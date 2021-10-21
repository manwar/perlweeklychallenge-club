#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-135/
# Task #2 > Validate SEDOL
#
# You are given 7-characters alphanumeric SEDOL.
#
# Write a script to validate the given SEDOL. Print 1 if it is a valid SEDOL otherwise 0.
#
# For more information about SEDOL, please checkout the wikipedia page (https://en.wikipedia.org/wiki/SEDOL)
#
# Example 1
# Input: $SEDOL = '2936921'
# Output: 1
# Example 2
# Input: $SEDOL = '1234567'
# Output: 0
# Example 3
# Input: $SEDOL = 'B0YBKL9'
# Output: 1

use strict;
use warnings;
use feature 'say';

my $sedol = shift;
say is_valid($sedol);
exit 0;

sub is_valid {
    my $sedol = shift;

    return 0 if !$sedol || $sedol !~ /^([0-9B-DF-HJ-NP-TV-Z]{6})([0-9])$/;
    my $code  = $1;
    my $check = $2;

    my $sum = 0;
    for (0 .. 5) {
        my $v = substr $code, $_, 1;     # value for numbers
        $v = ord($v) - 55 if $v !~ /\d/; # value for letters (alphabet position)
        $sum += $v * (1,3,1,7,3,9)[$_];  # weighted sum of values
    }

    return $check == (10 - $sum % 10) % 10 ? 1 : 0;
}

__END__

./ch-2.pl 2936921
1

./ch-2.pl 1234567
0

./ch-2.pl B0YBKL9
1
