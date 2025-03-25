#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-314/#TASK2
#
# Task 2: Sort Column
# ===================
#
# You are given a list of strings of same length.
#
# Write a script to make each column sorted lexicographically by deleting any
# non sorted columns.
#
# Return the total columns deleted.
#
## Example 1
##
## Input: @list = ("swpc", "tyad", "azbe")
## Output: 2
##
## swpc
## tyad
## azbe
##
## Column 1: "s", "t", "a" => non sorted
## Column 2: "w", "y", "z" => sorted
## Column 3: "p", "a", "b" => non sorted
## Column 4: "c", "d", "e" => sorted
##
## Total columns to delete to make it sorted lexicographically.
#
## Example 2
##
## Input: @list = ("cba", "daf", "ghi")
## Output: 1
#
## Example 3
##
## Input: @list = ("a", "b", "c")
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# We start by collecting all columns into arrays. Then we check
# each element of each column: if it is lexicographically bigger
# than its predecessor, we are still good. Otherwise, we delete
# the column and move on to the next.
# In the end, we return the amount of deleted columns.

use v5.36;
use Data::Dumper;

sort_column("swpc", "tyad", "azbe");
sort_column("cba", "daf", "ghi");
sort_column("a", "b", "c");

sub sort_column(@list) {
    say "Input: (" . join(", ", @list) . ")";
    my $columns;
    foreach my $string (@list) {
        my @chars = split //, $string;
        foreach my $i (0..$#chars) {
            push @{$columns->{$i}}, $chars[$i];
        }
    }
    my $deleted = 0;
    foreach my $c (sort { $a <=> $b } keys %$columns) {
        my $last = -1;
        foreach my $elem (@{$columns->{$c}}) {
            my $tmp = ord($elem);
            if($tmp < $last) {
                $deleted++;
                last;
            }
            $last = $tmp;
        }
    }
    say "Output: $deleted";
}
