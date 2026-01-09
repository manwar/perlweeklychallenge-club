#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK1
#
# Task 1: Thousand Separator
# ==========================
#
# You are given a positive integer, $int.
#
# Write a script to add thousand separator, , and return as string.
#
## Example 1
##
## Input: $int = 123
## Output: "123"
#
#
## Example 2
##
## Input: $int = 1234
## Output: "1,234"
#
#
## Example 3
##
## Input: $int = 1000000
## Output: "1,000,000"
#
#
## Example 4
##
## Input: $int = 1
## Output: "1"
#
#
## Example 5
##
## Input: $int = 12345
## Output: "12,345"
#
############################################################
##
## discussion
##
############################################################
#
# As long as $int is more than 3 characters long, we prepend the
# last 3 digits of it and a "," to the current temporary result
# string. If there are 3 or less, just prepend those and the "," to
# the temporary result string. In the end, we have added one
# unnecessary "," at the very end, so we just remove that.
#
use v5.36;

thousand_separator(123);
thousand_separator(1234);
thousand_separator(1000000);
thousand_separator(1);
thousand_separator(12345);

sub thousand_separator($int) {
    say "Input: $int";
    my $out = "";
    while(length($int) > 3) {
        my $t = substr($int, -3, 3, "");
        $out = "$t,$out";
    }
    $out = "$int,$out";
    $out =~ s/,$//;
    say "Output: $out";
}
