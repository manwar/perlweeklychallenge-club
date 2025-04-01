#!/bin/env perl

# Challenge 308
#
# Task 1: Count Common
# Submitted by: Mohammad Sajid Anwar
#
# You are given two array of strings, @str1 and @str2.
#
# Write a script to return the count of common strings in both arrays.
# Example 1
#
# Input: @str1 = ("perl", "weekly", "challenge")
#        @str2 = ("raku", "weekly", "challenge")
# Output: 2
#
# Example 2
#
# Input: @str1 = ("perl", "raku", "python")
#        @str2 = ("python", "java")
# Output: 1
#
# Example 3
#
# Input: @str1 = ("guest", "contribution")
#        @str2 = ("fun", "weekly", "challenge")
# Output: 0

use Modern::Perl;

my @lists = parse(@ARGV);
say scalar(find_common(@lists));

sub parse {
    my(@args) = @_;
    my @lists = split /,/, "@args";
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
                 sort {$a cmp $b} keys %common;
    return @common;
}
