#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-318/#TASK1
#
# Task 1: Group Position
# ======================
#
# You are given a string of lowercase letters.
#
# Write a script to find the position of all groups in the given string. Three
# or more consecutive letters form a group. Return "” if none found.
#
## Example 1
##
## Input: $str = "abccccd"
## Output: "cccc"
#
#
## Example 2
##
## Input: $str = "aaabcddddeefff"
## Output: "aaa", "dddd", "fff"
#
#
## Example 3
##
## Input: $str = "abcdd"
## Output: ""
#
############################################################
##
## discussion
##
############################################################
#
# We need to remember the last character and any already existing
# substring of $str that consists of only the same character.
# If the current character matches the last one, we just add it to
# the temporary string. If it doesn't match, we reset $lastchar and
# the temporary string to the current character. In the end, we also
# capture the current $tmpstr and add it to the result list in case it's
# longer than or equal to 3 characters.

use v5.36;

group_position("abccccd");
group_position("aaabcddddeefff");
group_position("abcdd");

sub group_position($str) {
    say "Input: \"$str\"";
    my @result = ();

    my $tmpstr = "";
    my $lastchar = "";
    my @chars = split//, $str;
    foreach my $char (@chars) {
        if($char eq $lastchar) {
            $tmpstr .= $char;
        } else {
            if(length($tmpstr) > 2) {
                push @result, $tmpstr;
            }
            $tmpstr = $char;
            $lastchar = $char;
        }
    }
    if(length($tmpstr) > 2) {
        push @result, $tmpstr;
    }

    say "Output: \"" . join("\", \"", @result) . "\"";
}
