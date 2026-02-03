#!/usr/bin/env perl

# Challenge 314
#
# Task 2: Sort Column
# Submitted by: Mohammad Sajid Anwar
# You are given a list of strings of same length.
#
# Write a script to make each column sorted lexicographically by deleting any non sorted columns.
#
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
# Example 2
# Input: @list = ("cba", "daf", "ghi")
# Output: 1
# Example 3
# Input: @list = ("a", "b", "c")
# Output: 0

use Modern::Perl;

say deleted_cols(@ARGV);

sub deleted_cols {
    my(@words) = @_;
    my @cols = transpose(@words);
    my $num_delete = scalar grep {sort_word($_) ne $_} @cols;
    return $num_delete;
}

sub transpose {
    my(@words) = @_;
    my @cols;
    for my $col (0 .. length($words[0]) - 1) {
        for my $row (0 .. $#words) {
            $cols[$col] .= substr($words[$row], $col, 1);
        }
    }
    return @cols;
}

sub sort_word {
    my($word) = @_;
    return join '', sort split //, $word;
}
