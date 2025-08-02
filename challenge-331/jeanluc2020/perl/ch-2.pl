#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-331/#TASK2
#
# Task 2: Buddy Strings
# =====================
#
# You are given two strings, source and target.
#
# Write a script to find out if the given strings are Buddy Strings.
#
## If swapping of a letter in one string make them same as the other then they
## are `Buddy Strings`.
#
#
## Example 1
##
## Input: $source = "fuck"
##        $target = "fcuk"
## Output: true
##
## The swapping of 'u' with 'c' makes it buddy strings.
#
#
## Example 2
##
## Input: $source = "love"
##        $target = "love"
## Output: false
#
#
## Example 3
##
## Input: $source = "fodo"
##        $target = "food"
## Output: true
#
#
## Example 4
##
## Input: $source = "feed"
##        $target = "feed"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# We split one of the words (let's decide for the target, but
# we could equally use the source here) into individual characters.
# Then we just try to swap each character against each other, and if
# the resulting string matches the source, we return true. Then we
# swap back of course, jumping to the next pair of characters to
# swap. If we didn't find a true solution at the end, we can
# return false.

use v5.36;

buddy_strings("fuck", "fcuk");
buddy_strings("love", "love");
buddy_strings("fodo", "food");
buddy_strings("feed", "feed");

sub buddy_strings($source, $target) {
    say "Input: \"$source\", \"$target\"";
    my @t_chars = split //, $target;
    foreach my $i (0..$#t_chars) {
        foreach my $j ($i+1..$#t_chars) {
            ($t_chars[$i], $t_chars[$j]) = ($t_chars[$j], $t_chars[$i]);
            my $tmp = join("", @t_chars);
            if($source eq $tmp) {
                return say "Output: true";
            }
            ($t_chars[$i], $t_chars[$j]) = ($t_chars[$j], $t_chars[$i]);
        }
    }
    say "Output: false";
}
