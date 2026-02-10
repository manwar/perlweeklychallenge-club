#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-360/#TASK1
#
# Task 1: Text Justifier
# ======================
#
# You are given a string and a width.
#
# Write a script to return the string that centers the text within that width
# using asterisks * as padding.
#
## Example 1
##
## Input: $str = "Hi", $width = 5
## Output: "*Hi**"
##
## Text length = 2, Width = 5
## Need 3 padding characters total
## Left padding: 1 star, Right padding: 2 stars
#
#
## Example 2
##
## Input: $str = "Code", $width = 10
## Output: "***Code***"
##
## Text length = 4, Width = 10
## Need 6 padding characters total
## Left padding: 3 stars, Right padding: 3 stars
#
#
## Example 3
##
## Input: $str = "Hello", $width = 9
## Output: "**Hello**"
##
## Text length = 5, Width = 9
## Need 4 padding characters total
## Left padding: 2 stars, Right padding: 2 stars
#
#
## Example 4
##
## Input: $str = "Perl", $width = 4
## Output: "Perl"
##
## No padding needed
#
#
## Example 5
##
## Input: $str = "A", $width = 7
## Output: "***A***"
##
## Text length = 1, Width = 7
## Need 6 padding characters total
## Left padding: 3 stars, Right padding: 3 stars
#
#
## Example 6
##
## Input: $str = "", $width = 5
## Output: "*****"
##
## Text length = 0, Width = 5
## Entire output is padding
#
############################################################
##
## discussion
##
############################################################
#
# Just add "*" as long as $str is still shorter than $width.
# Add those alternating on the right side and the left side
# of $str to balance them out.

use v5.36;

text_justifier("Hi", 5);
text_justifier("Code", 10);
text_justifier("Hello", 9);
text_justifier("Perl", 4);
text_justifier("A", 7);
text_justifier("", 5);

sub text_justifier($str, $width) {
    say "Input: \$str = \"$str\", \$width = $width";
    my $where = "r";
    while(length($str) < $width) {
        if($where eq "r") {
            $where = "l";
            $str .= "*";
        } else {
            $where = "r";
            $str = "*" . $str;
        }
    }
    say "Output: \"$str\"";
}
