#!/usr/bin/perl

# Challenge 193
#
# Task 2: Odd String
# Submitted by: Mohammad S Anwar
# You are given a list of strings of same length, @s.
#
# Write a script to find the odd string in the given list. Use positional value
# of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.
#
# Find the difference array for each string as shown in the example. Then pick
# the odd one out.
#
# Example 1:
# Input: @s = ("adc", "wzy", "abc")
# Output: "abc"
#
# Difference array for "adc" => [ d - a, c - d ]
#                            => [ 3 - 0, 2 - 3 ]
#                            => [ 3, -1 ]
#
# Difference array for "wzy" => [ z - w, y - z ]
#                            => [ 25 - 22, 24 - 25 ]
#                            => [ 3, -1 ]
#
# Difference array for "abc" => [ b - a, c - b ]
#                            => [ 1 - 0, 2 - 1 ]
#                            => [ 1, 1 ]
#
# The difference array for "abc" is the odd one.
# Example 2:
# Input: @s = ("aaa", "bob", "ccc", "ddd")
# Output: "bob"
#
# Difference array for "aaa" => [ a - a, a - a ]
#                            => [ 0 - 0, 0 - 0 ]
#                            => [ 0, 0 ]
#
# Difference array for "bob" => [ o - b, b - o ]
#                            => [ 14 - 1, 1 - 14 ]
#                            => [ 13, -13 ]
#
# Difference array for "ccc" => [ c - c, c - c ]
#                            => [ 2 - 2, 2 - 2 ]
#                            => [ 0, 0 ]
#
# Difference array for "ddd" => [ d - d, d - d ]
#                            => [ 3 - 3, 3 - 3 ]
#                            => [ 0, 0 ]
#
# The difference array for "bob" is the odd one.

use Modern::Perl;

sub string_diff {
    my($string)=@_;
    my @values = map {ord} split //, $string;
    my @diff = map {$values[$_+1]-$values[$_]} 0..$#values-1;
    return @diff;
}

sub odd_string {
    my(@strings)=@_;
    my %diffs;
    my %strings;
    for (@strings) {
        my @diffs = string_diff($_);
        $diffs{"@diffs"}++;
        $strings{"@diffs"}=$_;
    }
    my @odd = grep {$diffs{$_}==1} keys %diffs;
    return @odd==1 ? $strings{$odd[0]} : ".";
}

@ARGV or die "usage: ch-2.pl string...\n";
my @strings=@ARGV;
say odd_string(@strings);
