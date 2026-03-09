#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/#TASK2
#
# Task 2: Goal Parser
# ===================
#
# You are given a string, $str.
#
# Write a script to interpret the given string using Goal Parser.
#
##     The Goal Parser interprets “G” as the string “G”, “()” as the string
##     “o”, and “(al)” as the string “al”. The interpreted strings are then
##     concatenated in the original order.
#
## Example 1
##
## Input: $str = "G()(al)"
## Output: "Goal"
##
## G    -> "G"
## ()   -> "o"
## (al) -> "al"
#
## Example 2
##
## Input: $str = "G()()()()(al)"
## Output: "Gooooal"
##
## G       -> "G"
## four () -> "oooo"
## (al)    -> "al"
#
## Example 3
##
## Input: $str = "(al)G(al)()()"
## Output: "alGaloo"
##
## (al) -> "al"
## G    -> "G"
## (al) -> "al"
## ()   -> "o"
## ()   -> "o"
#
## Example 4
##
## Input: $str = "()G()G"
## Output: "oGoG"
##
## () -> "o"
## G  -> "G"
## () -> "o"
## G  -> "G"
#
## Example 5
##
## Input: $str = "(al)(al)G()()"
## Output: "alalGoo"
##
## (al) -> "al"
## (al) -> "al"
## G    -> "G"
## ()   -> "o"
## ()   -> "o"
#
############################################################
##
## discussion
##
############################################################
#
# As long as there are still characters in $str, we remove either
# a starting "G", "()" or "(al)", and add a "G", "o" or "al" to
# the result.

use v5.36;

goal_parser("G()(al)");
goal_parser("G()()()()(al)");
goal_parser("(al)G(al)()()");
goal_parser("()G()G");
goal_parser("(al)(al)G()()");

sub goal_parser($str) {
    say "Input: \"$str\"";
    my $result = "";
    while(length($str)) {
        if($str =~ m/^G/ ) {
            $result .= "G";
            $str =~ s/^.//;
        } elsif ($str =~ m/^\(\)/) {
            $result .= "o";
            $str =~ s/^..//;
        } elsif ($str =~ m/^\(al\)/) {
            $result .= "al";
            $str =~ s/^....//;
        } else {
            die "Unrecognized pattern in $str";
        }
    }
    say "Output: \"$result\"";
}
