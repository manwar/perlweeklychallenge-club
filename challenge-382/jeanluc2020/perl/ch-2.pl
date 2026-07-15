#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-382/#TASK2
#
# Task 2: Replace Question Mark
# =============================
#
# You are given a string that contains only 0, 1 and ? characters.
#
# Write a script to generate all possible combinations when replacing the
# question marks with a zero or one.
#
## Example 1
##
## Input: $str = "01??0"
## Output: ("01000", "01010", "01100", "01110")
#
## Example 2
##
## Input: $str = "101"
## Output: ("101")
#
## Example 3
##
## Input: $str = "???"
## Output: ("000", "001", "010", "011", "100", "101", "110", "111")
#
## Example 4
##
## Input: $str = "1?10"
## Output: ("1010", "1110")
#
## Example 5
##
## Input: $str = "1?1?0"
## Output: ("10100", "10110", "11100", "11110")
#
############################################################
##
## discussion
##
############################################################
#
# We recursively create all possible outputs: First, we split the
# input string into digits, then we recursively
# - pick the first character as $first
# - create all possible outputs for the remaining digits
# - if $first is "?", create "0$str" and "1$str" for all $str in
#   the results of the remaining digits. Otherwise, just add
#   "$first$str" for each of them
# - in the end, sort the result for a consistent result
#

use v5.36;

replace_question_mark("01??0");
replace_question_mark("101");
replace_question_mark("???");
replace_question_mark("1?10");
replace_question_mark("1?1?0");

sub replace_question_mark($str) {
    say "Input: \"$str\"";
    my @digits = split //, $str;
    my @result = get_replaced(@digits);
    say "Output: (\"" . join("\", \"", sort @result) . "\")";
}

sub get_replaced(@digits) {
    return ("") unless @digits;
    my $first = shift @digits;
    my @tmp = get_replaced(@digits);
    my @result;
    if($first eq "?") {
        foreach my $elem (@tmp) {
            push @result, "0$elem";
            push @result, "1$elem";
        }
    } else {
        foreach my $elem (@tmp) {
            push @result, "$first$elem";
        }
    }
    return @result;
}
