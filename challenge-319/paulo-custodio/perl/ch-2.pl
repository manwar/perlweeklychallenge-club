#!/usr/bin/env perl

# Challenge 319
#
# Task 2: Minimum Common
# Submitted by: Mohammad Sajid Anwar
# You are given two arrays of integers.
#
# Write a script to return the minimum integer common to both arrays. If none found return -1.
#
#
# Example 1
# Input: @array_1 = (1, 2, 3, 4)
#        @array_2 = (3, 4, 5, 6)
# Output: 3
#
# The common integer in both arrays: 3, 4
# The minimum is 3.
#
# Example 2
# Input: @array_1 = (1, 2, 3)
#        @array_2 = (2, 4)
# Output: 2
#
# Example 3
# Input: @array_1 = (1, 2, 3, 4)
#        @array_2 = (5, 6, 7, 8)
# Output: -1

use Modern::Perl;

my @n1 = split ' ', <>;
my @n2 = split ' ', <>;
say min_common(\@n1, \@n2);

sub min_common {
    my($n1, $n2) = @_;
    my %n1;
    my @common;
    for (@$n1) { $n1{$_} = 1; }
    for (@$n2) { push @common, $_ if $n1{$_}; }
    @common = sort {$a<=>$b} @common;
    return @common==0 ? -1 : $common[0];
}
