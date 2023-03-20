#!/usr/bin/env perl

# Task 1: Minimum Index Sum
# Submitted by: Mohammad S Anwar
# 
# You are given two arrays of strings.
# Write a script to find out all common strings in the given two arrays with minimum index sum. If no common strings found returns an empty list.
# 
# Example 1
# Input: @list1 = ("Perl", "Raku", "Love")
#        @list2 = ("Raku", "Perl", "Hate")
# Output: ("Perl", "Raku")
# 
# There are two common strings "Perl" and "Raku".
# Index sum of "Perl": 0 + 1 = 1
# Index sum of "Raku": 1 + 0 = 1
# 
# Example 2
# Input: @list1 = ("A", "B", "C")
#        @list2 = ("D", "E", "F")
# Output: ()
# 
# No common string found, so no result.
# 
# Example 3
# Input: @list1 = ("A", "B", "C")
#        @list2 = ("C", "A", "B")
# Output: ("A")
# 
# There are three common strings "A", "B" and "C".
# Index sum of "A": 0 + 1 = 1
# Index sum of "B": 1 + 2 = 3
# Index sum of "C": 2 + 0 = 2

use strict;
use warnings;
use feature 'say';

say get_minimum_index_sum(["Perl", "Raku", "Love"],
                          ["Raku", "Perl", "Hate"]
                         );
say get_minimum_index_sum(["A", "B", "C"],
                          ["D", "E", "F"]
                         );
say get_minimum_index_sum(["A", "B", "C"],
                          ["C", "A", "B"]
                         );

exit 0;

sub get_minimum_index_sum {
    my ($list1, $list2) = @_;

    my @words;
    my $value;
    foreach my $i (0..scalar(@$list1)-1) {
        foreach my $j (0..scalar(@$list2)-1) {
            last
                if defined($value) and $value < $i + $j;
            if ($list1->[$i] eq $list2->[$j]) {
                if (!defined($value)
                    or
                    $value > $i+$j
                ) {
                    @words = ();
                    $value = $i+$j;
                }
                push @words, "\"$list1->[$i]\"";
                last;
            }
        }
    }
    return sprintf "(%s)", join ', ', @words;
}
