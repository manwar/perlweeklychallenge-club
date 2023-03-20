#!/usr/bin/perl

# Challenge 208
#
# Task 1: Minimum Index Sum
# Submitted by: Mohammad S Anwar
#
# You are given two arrays of strings.
#
# Write a script to find out all common strings in the given two arrays with
# minimum index sum. If no common strings found returns an empty list.
# Example 1
#
# Input: @list1 = ("Perl", "Raku", "Love")
#        @list2 = ("Raku", "Perl", "Hate")
#
# Output: ("Perl", "Raku")
#
# There are two common strings "Perl" and "Raku".
# Index sum of "Perl": 0 + 1 = 1
# Index sum of "Raku": 1 + 0 = 1
#
# Example 2
#
# Input: @list1 = ("A", "B", "C")
#        @list2 = ("D", "E", "F")
#
# Output: ()
#
# No common string found, so no result.
#
# Example 3
#
# Input: @list1 = ("A", "B", "C")
#        @list2 = ("C", "A", "B")
#
# Output: ("A")
#
# There are three common strings "A", "B" and "C".
# Index sum of "A": 0 + 1 = 1
# Index sum of "B": 1 + 2 = 3
# Index sum of "C": 2 + 0 = 2

use Modern::Perl;

sub common_strings {
    my($list1, $list2) = @_;
    my @list1 = @$list1;
    my @list2 = @$list2;
    my $min_index = @list1 + @list2 + 1;
    my @common;

    for my $i (0 .. $#list1) {
        for my $j (0 .. $#list2) {
            if ($list1[$i] eq $list2[$j]) {
                if ($i+$j < $min_index) {
                    $min_index = $i+$j;
                    @common = $list1[$i];
                }
                elsif ($i+$j == $min_index) {
                    push @common, $list1[$i];
                }
            }
        }
    }

    return @common;
}

my @list1 = @ARGV[0..@ARGV/2-1];
my @list2 = @ARGV[@ARGV/2..$#ARGV];

my @common = common_strings(\@list1, \@list2);
say @common ? "@common" : "()";
