#!/usr/bin/perl

# Challenge 195
#
# Task 1: Special Integers
# Submitted by: Mohammad S Anwar
# You are given a positive integer, $n > 0.
#
# Write a script to print the count of all special integers between 1 and $n.
#
# An integer is special when all of its digits are unique.
#
# Example 1:
# Input: $n = 15
# Output: 14 as except 11 all other integers between 1 and 15 are spcial.
# Example 2:
# Input: $n = 35
# Output: 32 as except 11, 22, 33 all others are special.

use Modern::Perl;

sub is_special_int {
    my($n)=@_;
    my @digits;
    for my $digit (split //, $n) {
        return 0 if $digits[$digit];
        $digits[$digit]=1;
    }
    return 1;
}

sub count_special_ints {
    my($n)=@_;
    my $count=0;
    for my $i (1..$n) {
        $count++ if is_special_int($i);
    }
    return $count;
}

@ARGV==1 or die "usage: ch-1.pl n\n";
my $n=shift;
say count_special_ints($n);
