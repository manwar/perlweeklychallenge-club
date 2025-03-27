#!/usr/bin/env perl

# Task 2: Sort Column
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of strings of same length.
# Write a script to make each column sorted lexicographically by deleting any non sorted columns.
# Return the total columns deleted.
# 
# Example 1
# Input: @list = ("swpc", "tyad", "azbe")
# Output: 2
# 
# swpc
# tyad
# azbe
# 
# Column 1: "s", "t", "a" => non sorted
# Column 2: "w", "y", "z" => sorted
# Column 3: "p", "a", "b" => non sorted
# Column 4: "c", "d", "e" => sorted
# 
# Total columns to delete to make it sorted lexicographically.
# 
# Example 2
# Input: @list = ("cba", "daf", "ghi")
# Output: 1
# 
# Example 3
# Input: @list = ("a", "b", "c")
# Output: 0

use strict;
use warnings;

my @list = ("swpc", "tyad", "azbe");
sorted_by_deleting(\@list);

@list = ("cba", "daf", "ghi");
sorted_by_deleting(\@list);

@list = ("a", "b", "c");
sorted_by_deleting(\@list);

exit 0;

sub sorted_by_deleting {
    my $list = shift;

    my @columns;
    foreach my $word (@$list) {
        my @chars = split //, $word;
        while (my ($i, $value) = each @chars) {
            push @{ $columns[$i] }, $value;
        }
    }
    my $unsorted = 0;
    foreach my $column (@columns) {
        $unsorted += 1
            if (join '', sort { $a cmp $b } @$column)
               ne
               (join '', @$column);
    }

    printf "%s -> %d\n",
        (join ', ', ( map { sprintf "'%s'", $_ } @$list ) ),
        $unsorted;
}
