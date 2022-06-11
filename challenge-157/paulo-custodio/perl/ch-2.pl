#!/usr/bin/env perl

# Challenge 157
#
# TASK #2 › Brazilian Number
# Submitted by: Mohammad S Anwar
# You are given a number $n > 3.
#
# Write a script to find out if the given number is a Brazilian Number.
#
# A positive integer number N has at least one natural number B where
# 1 < B < N-1 where the representation of N in base B has same digits.
#
#
# Example 1:
# Input: $n = 7
# Output: 1
#
# Since 7 in base 2 is 111.
# Example 2:
# Input: $n = 6
# Output: 0
#
# Since 6 in base 2 is 110,
#       6 in base 3 is 20 and
#       6 in base 4 is 12.
# Example 3:
# Input: $n = 8
# Output: 1
#
# Since 8 in base 3 is 22.

use Modern::Perl;
use Math::BaseCnv qw( cnv );

my $n = $ARGV[0] or die "Usage: ch-2.pl n\n";
say is_brazilian($n);

sub is_brazilian {
    my($n) = @_;
    for my $b (2 .. $n-2) {
        my $cnv = cnv($n, 10, $b);
        return 1 if $cnv =~ /^(\w)\1*$/;
    }
    return 0;
}
