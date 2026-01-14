#!/usr/bin/env perl

# Challenge 350
#
# Task 1: Good Substrings
# Submitted by: Mohammad Sajid Anwar
# You are given a string.
#
# Write a script to return the number of good substrings of length three in the given string.
#
# A string is good if there are no repeated characters.
#
#
# Example 1
# Input: $str = "abcaefg"
# Output: 5
#
# Good substrings of length 3: abc, bca, cae, aef and efg
#
# Example 2
# Input: $str = "xyzzabc"
# Output: 3
#
# Good substrings of length 3: "xyz", "zab" and "abc"
#
# Example 3
# Input: $str = "aababc"
# Output: 1
#
# Good substrings of length 3: "abc"
#
# Example 4
# Input: $str = "qwerty"
# Output: 4
#
# Good substrings of length 3: "qwe", "wer", "ert" and "rty"
#
# Example 5
# Input: $str = "zzzaaa"
# Output: 0

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
my $string = shift;
my @subs = find_substrings(3, $string);
my @good = grep {is_good($_)} @subs;

say scalar(@good);

sub find_substrings {
    my($len, $str) = @_;
    my @out;
    for my $i (0 .. length($str) - $len) {
        push @out, substr($str, $i, $len);
    }
    return @out;
}

sub is_good {
    my($str) = @_;
    my %count;
    for my $c (split //, $str) {
        return if $count{$c}++;
    }
    return 1;
}
