#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-385/#TASK2
#
# Task 2: Outermost Parentheses
# =============================
#
# You are given a valid parentheses string.
#
# Write a script to return the string after removing the outermost parentheses
# of every primitive string in the primitive decomposition of the given string.
#
## Example 1
##
## Input: $str = "()()()"
## Output: ""
##
## Primitive Decomposition: "()" + "()" + "()"
#
## Example 2
##
## Input: $str = "(((())))"
## Output: "((()))"
##
## Primitive Decomposition: "(((())))"
#
## Example 3
##
## Input: $str = "(()())(())"
## Output: "()()()"
##
## Primitive Decomposition: "(()())" + "(())"
#
## Example 4
##
## Input: $str = "()((()))()"
## Output: "(())"
##
## Primitive Decomposition: "()" + "((()))" + "()"
#
## Example 5
##
## Input: $str = "(()(()))(()())"
## Output: "()(())()()"
##
## Primitive Decomposition: "(()(()))" + "(()())"
#
############################################################
##
## discussion
##
############################################################
#
# We walk $str character by character, keeping track of how deep we
# are into nested "()"s. We skip the opening "(" at level 0 and
# the closing ")" at level 1, but add all other "()"s to the
# output.

use v5.36;

outermost_parantheses("()()()");
outermost_parantheses("(((())))");
outermost_parantheses("(()())(())");
outermost_parantheses("()((()))()");
outermost_parantheses("(()(()))(()())");

sub outermost_parantheses($str) {
    say "Input: \"$str\"";
    my $output = "";
    my $level = 0;
    foreach my $char (split //, $str) {
        if($level == 0) {
            if($char eq "(") {
                $level++;
                next;
            }
            # we shouldn't end up here as the input strings are valid
        } elsif ($level == 1) {
            if($char eq ")") {
                $level--;
            } else {
                $level++;
                $output .= $char;
            }
            next;
        }
        $output .= $char;
        if($char eq "(") {
            $level++;
        } else {
            $level--;
        }
    }
    say "Output: \"$output\"";
}
