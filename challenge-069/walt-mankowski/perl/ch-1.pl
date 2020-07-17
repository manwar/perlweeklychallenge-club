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

my @flip = qw(0 1 x x x x 9 x 8 6);

my ($A, $B) = @ARGV;
for my $n ($A..$B) {
    say $n if is_strobogrammatic($n);
}

sub is_strobogrammatic($n) {
    my $flipped = $n;
    $flipped =~ tr/0123456789/01xxxx9x86/;
    return $n eq scalar reverse $flipped;
}
