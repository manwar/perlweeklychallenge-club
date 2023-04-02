#!/usr/bin/perl

# Challenge 192
#
# Task 1: Binary Flip
# Submitted by: Mohammad S Anwar
#
# You are given a positive integer, $n.
#
# Write a script to find the binary flip.
# Example 1
#
# Input: $n = 5
# Output: 2
#
# First find the binary equivalent of the given integer, 101.
# Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.
# So Binary 010 => Decimal 2.
#
# Example 2
#
# Input: $n = 4
# Output: 3
#
# Decimal 4 = Binary 100
# Flip 0 -> 1 and 1 -> 0, we get 011.
# Binary 011 = Decimal 3
#
# Example 3
#
# Input: $n = 6
# Output: 1
#
# Decimal 6 = Binary 110
# Flip 0 -> 1 and 1 -> 0, we get 001.
# Binary 001 = Decimal 1

use Modern::Perl;

sub flip {
    my($n)=@_;
    my $len=length(sprintf("%b",$n));
    my $mask=2**$len-1;
    return (~$n)&$mask;
}

@ARGV==1 or die "usage: ch-2.pl n\n";
my $n=shift||0;
say flip($n);
