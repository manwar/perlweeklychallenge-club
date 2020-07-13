#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › Strobogrammatic Number
# Submitted by: Mohammad S Anwar
# 
# A strobogrammatic number is a number that looks the same when looked at upside down.
# 
# You are given two positive numbers $A and $B such that 1 <= $A <= $B <= 10^15.
# 
# Write a script to print all strobogrammatic numbers between the given two numbers.
# Example
# 
# Input: $A = 50, $B = 100
#     Output: 69, 88, 96

my %flip = (0 => 0,
            1 => 1,
            2 => 'x',
            3 => 'x',
            4 => 'x',
            5 => 'x',
            6 => 9,
            7 => 'x',
            8 => 8,
            9 => 6);

my ($A, $B) = @ARGV;
for my $n ($A..$B) {
    say $n if is_strobogrammatic($n);
}

sub is_strobogrammatic($n) {
    my $flipped = join '', reverse map { $flip{$_} } split //, $n;
    return $n eq $flipped;
}
