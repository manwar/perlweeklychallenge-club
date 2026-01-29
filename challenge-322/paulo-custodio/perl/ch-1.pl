#!/usr/bin/env perl

# Challenge 322
#
# Task 1: String Format
# Submitted by: Mohammad Sajid Anwar
# You are given a string and a positive integer.
#
# Write a script to format the string, removing any dashes, in groups of size given by the integer. The first group can be smaller than the integer but should have at least one character. Groups should be separated by dashes.
#
#
# Example 1
# Input: $str = "ABC-D-E-F", $i = 3
# Output: "ABC-DEF"
#
# Example 2
# Input: $str = "A-BC-D-E", $i = 2
# Output: "A-BC-DE"
#
# Example 3
# Input: $str = "-A-B-CD-E", $i = 4
# Output: "A-BCDE"

use Modern::Perl;

@ARGV==2 or die "usage: $0 str num\n";
say format_str(@ARGV);

sub format_str {
    my($str, $num) = @_;
    $str =~ s/-//g;
    my @out;
    while (length($str) > $num) {
        unshift @out, substr($str, length($str)-$num);
        $str = substr($str, 0, length($str)-$num);
    }
    unshift @out, $str if $str ne '';
    return join "-", @out;
}
