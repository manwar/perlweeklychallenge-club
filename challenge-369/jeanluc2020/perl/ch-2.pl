#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-369/#TASK2
#
# Task 2: Group Division
# ======================
#
# You are given a string, group size and filler character.
#
# Write a script to divide the string into groups of given size. In the last
# group if the string doesn’t have enough characters remaining fill with the
# given filler character.
#
## Example 1
##
## Input: $str = "RakuPerl", $size = 4, $filler = "*"
## Output: ("Raku", "Perl")
#
## Example 2
##
## Input: $str = "Python", $size = 5, $filler = "0"
## Output: ("Pytho", "n0000")
#
## Example 3
##
## Input: $str = "12345", $size = 3, $filler = "x"
## Output: ("123", "45x")
#
## Example 4
##
## Input: $str = "HelloWorld", $size = 3, $filler = "_"
## Output: ("Hel", "loW", "orl", "d__")
#
## Example 5
##
## Input: $str = "AI", $size = 5, $filler = "!"
## Output: "AI!!!"
#
############################################################
##
## discussion
##
############################################################
#
# As long as $str still has a positive length, we capture the first
# up to $size characters in a temporary string, set $str to the
# remainder after removing that part, and fill up the temporary
# string with $filler as needed. We keep all of these strings
# in an array so we can print it in the end.

use v5.36;

group_division("RakuPerl", 4, "*");
group_division("Python", 5, "0");
group_division("12345", 3, "x");
group_division("HelloWorld", 3, "_");
group_division("AI", 5, "!");

sub group_division($str, $size, $filler) {
    say "Input: \$str = \"$str\", \$size = $size, \$filler = \"$filler\"";
    my @result = ();
    while(length($str)) {
        my $tmp = substr($str, 0, $size);
        $str = length($str) >= $size ? substr($str, $size) : "";
        my $len = $size - length($tmp);
        $tmp .= $filler x $len if $len;
        push @result, $tmp;
    }
    say "Output: (\"" . join("\", \"", @result) . "\")";
}
