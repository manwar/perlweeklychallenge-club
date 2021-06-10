#!/usr/bin/env perl

# Challenge 114
#
# TASK #2 - Higher Integer Set Bits
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# Write a script to find the next higher integer having the same number of
# 1 bits in binary representation as $N.
#
# Example
# Input: $N = 3
# Output: 5
#
# Binary representation of $N is 011. There are two 1 bits. So the next higher
# integer is 5 having the same the number of 1 bits i.e. 101.
#
# Input: $N = 12
# Output: 17
#
# Binary representation of $N is 1100. There are two 1 bits. So the next higher
# integer is 17 having the same number of 1 bits i.e. 10001.

use Modern::Perl;

my $N = shift || 0;
say next_same_1bits($N);

sub num_1bits {
    my($n) = @_;
    my $sum = 0;
    map {$sum += $_} split //, sprintf("%b", $n);
    return $sum;
}

sub next_same_1bits {
    my($n) = @_;
    my $num1s = num_1bits($n);
    while (1) {
        $n++;
        return $n if num_1bits($n) == $num1s;
    }
}
