#!/bin/env perl

# Challenge 310
#
# Task 1: Arrays Intersection
# Submitted by: Mohammad Sajid Anwar
#
# You are given a list of array of integers.
#
# Write a script to return the common elements in all the arrays.
# Example 1
#
# Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
# Output: (1, 4)
#
# Example 2
#
# Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
# Output: (2)
#
# Example 3
#
# Input: $list = ( [1, 2, 3], [4, 5], [6] )
# Output: ()

use Modern::Perl;

my @lists = parse(@ARGV);
my @common = find_common(@lists);
say "(", join(", ", @common), ")";

sub parse {
    my(@args) = @_;
    my @lists = split(/,/, "@args");
    for (@lists) {
        $_ = [split ' ', $_];
    }
    return @lists;
}

sub find_common {
    my(@lists) = @_;

    my %common;
    for (@lists) {
        my @list = @$_;
        my %found;
        for (@list) {
            if (!$found{$_}++) {
                $common{$_}++;
            }
        }
    }

    my @common = grep {$common{$_}==scalar(@lists)}
                 sort {$a<=>$b} keys %common;
    return @common;
}
