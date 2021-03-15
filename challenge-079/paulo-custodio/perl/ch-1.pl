#!/usr/bin/perl

# Challenge 079
#
# TASK #1 › Count Set Bits
# Submitted by: Mohammad S Anwar
# You are given a positive number $N.
#
# Write a script to count the total numbrer of set bits of the binary representations of all numbers from 1 to $N and return $total_count_set_bit % 1000000007.
#
# Example 1:
# Input: $N = 4
#
# Explanation: First find out the set bit counts of all numbers i.e. 1, 2, 3 and 4.
#
#     Decimal: 1
#     Binary: 001
#     Set Bit Counts: 1
#
#     Decimal: 2
#     Binary: 010
#     Set Bit Counts: 1
#
#     Decimal: 3
#     Binary: 011
#     Set Bit Counts: 2
#
#     Decimal: 4
#     Binary: 100
#     Set Bit Counts: 1
#
#     Total set bit count: 1 + 1 + 2 + 1 = 5
#
# Output: Your script should print `5` as `5 % 1000000007 = 5`.
# Example 2:
# Input: $N = 3
#
# Explanation: First find out the set bit counts of all numbers i.e. 1, 2 and 3.
#
#     Decimal: 1
#     Binary: 01
#     Set Bit Count: 1
#
#     Decimal: 2
#     Binary: 10
#     Set Bit Count: 1
#
#     Decimal: 3
#     Binary: 11
#     Set Bit Count: 2
#
#     Total set bit count: 1 + 1 + 2 = 4
#
# Output: Your script should print `4` as `4 % 1000000007 = 4`.

use strict;
use warnings;
use 5.030;

@ARGV==1 or die "Usage: ch-1.pl N\n";
say(sum(map {bit_count($_)} 1..$ARGV[0])  % 1000000007);

sub bit_count {
    my($n) = @_;
    my $count = 0;
    while ($n > 0) {
        $count++ if $n & 1;
        $n >>= 1;
    }
    return $count;
}

sub sum {
    my($sum, @a) = @_;
    $sum += $_ for @a;
    return $sum;
}
