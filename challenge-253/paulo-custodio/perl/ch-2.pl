#!/usr/bin/env perl

# Challenge 253
#
# Task 2: Weakest Row
# Submitted by: Mohammad S Anwar
# You are given an m x n binary matrix i.e. only 0 and 1 where 1 always appear before 0.
#
# A row i is weaker than a row j if one of the following is true:
#
# a) The number of 1s in row i is less than the number of 1s in row j.
# b) Both rows have the same number of 1 and i < j.
# Write a script to return the order of rows from weakest to strongest.
#
# Example 1
# Input: $matrix = [
#                    [1, 1, 0, 0, 0],
#                    [1, 1, 1, 1, 0],
#                    [1, 0, 0, 0, 0],
#                    [1, 1, 0, 0, 0],
#                    [1, 1, 1, 1, 1]
#                  ]
# Output: (2, 0, 3, 1, 4)
#
# The number of 1s in each row is:
# - Row 0: 2
# - Row 1: 4
# - Row 2: 1
# - Row 3: 2
# - Row 4: 5
# Example 2
# Input: $matrix = [
#                    [1, 0, 0, 0],
#                    [1, 1, 1, 1],
#                    [1, 0, 0, 0],
#                    [1, 0, 0, 0]
#                  ]
# Output: (0, 2, 3, 1)
#
# The number of 1s in each row is:
# - Row 0: 1
# - Row 1: 4
# - Row 2: 1
# - Row 3: 1

use Modern::Perl;
use List::Util 'sum';

my $matrix = parse_matrix("@ARGV");
say join " ",
        map {$_->[0]}
        sort {$a->[1] == $b->[1] ? $a->[0] <=> $b->[0] : $a->[1] <=> $b->[1]}
        map {[$_, sum(@{$matrix->[$_]})]} 0 .. $#$matrix;

sub parse_matrix {
    my($text) = @_;
    my @lines = split(/\]\s*,/, $text);
    my $matrix = [];
    for (@lines) {
        s/^\D+//;
        my @nums = split /\D+/, $_;
        push @$matrix, \@nums;
    }
    return $matrix;
}
