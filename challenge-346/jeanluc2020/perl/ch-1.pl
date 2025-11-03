#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-346/#TASK1
#
# Task 1: Longest Parenthesis
# ===========================
#
# You are given a string containing only ( and ).
#
# Write a script to find the length of the longest valid parenthesis.
#
## Example 1
##
## Input: $str = '(()())'
## Output: 6
##
## Valid Parenthesis: '(()())'
#
#
## Example 2
##
## Input: $str = ')()())'
## Output: 4
##
## Valid Parenthesis: '()()' at positions 1-4.
#
#
## Example 3
##
## Input: $str = '((()))()(((()'
## Output: 8
##
## Valid Parenthesis: '((()))()' at positions 0-7.
#
#
## Example 4
##
## Input: $str = '))))((()('
## Output: 2
##
## Valid Parenthesis: '()' at positions 6-7.
#
#
## Example 5
##
## Input: $str = '()(()'
## Output: 2
##
## Valid Parenthesis: '()' at positions 0-1 and 3-4.
#
############################################################
##
## discussion
##
############################################################
#
# We create all possible substrings and check whether they are
# valid. We keep track of the longest one and return it in the
# end.

use v5.35;

longest_parenthesis('(()())');
longest_parenthesis(')()())');
longest_parenthesis('((()))()(((()');
longest_parenthesis('))))((()(');
longest_parenthesis('()(()');

sub longest_parenthesis($str) {
    say "Input: '$str'";
    my $longest = 0;
    my @parts = split //, $str;
    foreach my $i (0..$#parts) {
        foreach my $j (0..$#parts) {
            my $current = join("", @parts[$i..$j]);
            if(is_valid($current)) {
                my $l = length($current);
                $longest = $l if $l > $longest;
            }
        }
    }
    say "Output: $longest";
}

sub is_valid($str) {
    my @parts = split //, $str;
    my $open = 0;
    foreach my $elem (@parts) {
        if($elem eq "(") {
            $open++;
        } else {
            $open--;
        }
        return 0 if $open < 0;
    }
    return $open == 0;
}
