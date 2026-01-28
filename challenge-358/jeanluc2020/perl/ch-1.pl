#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-358/#TASK1
#
# Task 1: Max Str Value
# =====================
#
# You are given an array of alphanumeric string, @strings.
#
# Write a script to find the max value of alphanumeric string in the given
# array. The numeric representation of the string, if it comprises of digits
# only otherwise length of the string.
#
## Example 1
##
## Input: @strings = ("123", "45", "6")
## Output: 123
##
## "123" -> 123
## "45"  -> 45
## "6"   -> 6
#
#
## Example 2
##
## Input: @strings = ("abc", "de", "fghi")
## Output: 4
##
## "abc"  -> 3
## "de"   -> 2
## "fghi" -> 4
#
#
## Example 3
##
## Input: @strings = ("0012", "99", "a1b2c")
## Output: 99
##
## "0012"  -> 12
## "99"    -> 99
## "a1b2c" -> 5
#
#
## Example 4
##
## Input: @strings = ("x", "10", "xyz", "007")
## Output: 10
##
## "x"   -> 1
## "xyz" -> 3
## "007" -> 7
## "10"  -> 10
#
#
## Example 5
##
## Input: @strings = ("hello123", "2026", "perl")
## Output: 2026
##
## "hello123" -> 8
## "perl"     -> 4
## "2026"     -> 2026
#
############################################################
##
## discussion
##
############################################################
#
# We calculate the value of each element, then we keep track
# of the maximum.

use v5.36;

max_str_value("123", "45", "6");
max_str_value("abc", "de", "fghi");
max_str_value("0012", "99", "a1b2c");
max_str_value("x", "10", "xyz", "007");
max_str_value("hello123", "2026", "perl");

sub max_str_value(@strings) {
    say "Input: (\"" . join("\", \"", @strings) . "\")";
    my $max;
    foreach my $elem (@strings) {
        my $val;
        if($elem =~ m/^\d+$/) {
            $val = $elem;
        } else {
            $val = length($elem);
        }
        $max = $val unless $max;
        $max = $val if $val > $max;
    }
    say "Output: $max";
}
