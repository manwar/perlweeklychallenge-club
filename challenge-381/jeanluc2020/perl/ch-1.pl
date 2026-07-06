#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-381/#TASK1
#
# Task 1: Same Row Column
# =======================
#
# You are given a n x n matrix containing integers from 1 to n.
#
# Write a script to find if every row and every column contains all the
# integers from 1 to n.
#
## Example 1
##
## Input: @matrix = ([1, 2, 3, 4],
##                   [2, 3, 4, 1],
##                   [3, 4, 1, 2],
##                   [4, 1, 2, 3],)
## Output: true
#
## Example 2
##
## Input: @matrix = ([1])
## Output: true
#
## Example 3
##
## Input: @matrix = ([1, 2, 5],
##                   [5, 1, 2],
##                   [2, 5, 1],)
## Output: false
##
## Elements are out of range 1..3.
#
## Example 4
##
## Input: @matrix = ([1, 2, 3],
##                   [1, 2, 3],
##                   [1, 2, 3],)
## Output: false
#
## Example 5
##
## Input: @matrix = ([1, 2, 3],
##                   [3, 1, 2],
##                   [3, 2, 1],)
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# We just need to check whether each row and column contains
# all the numbers from 1..n. So we just do that, returning
# false in case any row or column doesn't fulfil this simple
# requirement.

use v5.36;

same_row_column([1, 2, 3, 4], [2, 3, 4, 1],
                [3, 4, 1, 2], [4, 1, 2, 3]);
same_row_column([1]);
same_row_column([1, 2, 5], [5, 1, 2], [2, 5, 1]);
same_row_column([1, 2, 3], [1, 2, 3], [1, 2, 3]);
same_row_column([1, 2, 3], [3, 1, 2], [3, 2, 1]);

sub same_row_column(@matrix) {
    say "Input: (";
    foreach my $line (@matrix) {
        say "[" . join(", ", @$line) . "],";
    }
    say ")";
    my $n = scalar(@matrix);
    foreach my $line (@matrix) {
        return say "Output: false" unless is_this_ok(@$line);
    }
    foreach my $column (0..$n-1) {
        my @tmp = ();
        foreach my $line (@matrix) {
            push @tmp, $line->[$column];
        }
        return say "Output: false" unless is_this_ok(@tmp);
    }
    say "Output: true";
}

sub is_this_ok(@array) {
    my $n = scalar(@array);
    my $seen = {};
    foreach my $elem (@array) {
        $seen->{$elem} = 1;
    }
    foreach my $i (1..$n) {
        return 0 unless $seen->{$i};
    }
    return 1;
}
