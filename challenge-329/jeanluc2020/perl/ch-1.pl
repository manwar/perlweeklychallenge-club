#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-329/#TASK1
#
# Task 1: Counter Integers
# ========================
#
# You are given a string containing only lower case English letters and digits.
#
# Write a script to replace every non-digit character with a space and then
# return all the distinct integers left.
#
## Example 1
##
## Input: $str = "the1weekly2challenge2"
## Output: 1, 2
##
## 2 is appeared twice, so we count it one only.
#
#
## Example 2
##
## Input: $str = "go21od1lu5c7k"
## Output: 21, 1, 5, 7
#
#
## Example 3
##
## Input: $str = "4p3e2r1l"
## Output: 4, 3, 2, 1
#
############################################################
##
## discussion
##
############################################################
#
# This one is fairly simple:
# - replace all non-digits by whitespace
# - remove leading or trailing whitespace
# - split string at whitespaces into individual integers
# - for each integer, put it into the result array unless it's
#   already there

use v5.36;

counter_integers("the1weekly2challenge2");
counter_integers("go21od1lu5c7k");
counter_integers("4p3e2r1l");

sub counter_integers($str) {
    say "Input: \"$str\"";
    $str =~ s/[^\d]/ /g;
    $str =~ s/^\s+//;
    $str =~ s/\s+$//;
    my @integers = split /\s+/, $str;
    my @result = ();
    my $seen = {};
    foreach my $integer (@integers) {
        push @result, $integer unless $seen->{$integer};
        $seen->{$integer} = 1;
    }
    say "Output: " . join(", ", @result);
}

