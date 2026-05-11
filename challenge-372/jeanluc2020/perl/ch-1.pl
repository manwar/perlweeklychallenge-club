#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-372/#TASK1
#
# Task 1: Rearrange Spaces
# ========================
#
# You are given a string text of words that are placed among number of spaces.
#
# Write a script to rearrange the spaces so that there is an equal number of
# spaces between every pair of adjacent words and that number is maximised. If
# you can’t distribute, place the extra spaces at the end. Finally return the
# string.
#
## Example 1
##
## Input: $str = "  challenge  "
## Output: "challenge    "
##
## We have 4 spaces and 1 word. So all spaces go to the end.
#
## Example 2
##
## Input: $str = "coding  is  fun"
## Output: "coding  is  fun"
##
## We have 4 spaces and 3 words (2 gaps). So 2 spaces per gap.
#
## Example 3
##
## Input: $str = "a b c  d"
## Output: "a b c d "
##
## We have 4 spaces and 4 words (3 gaps). So 1 space per gap and 1 remainder.
#
## Example 4
##
## Input: $str = "  team      pwc  "
## Output: "team          pwc"
##
## We have 10 spaces and 2 words (1 gap). So 10 spaces per gap.
#
## Example 5
##
## Input: $str = "   the  weekly  challenge  "
## Output: "the    weekly    challenge "
##
## We have 9 spaces and 3 words (2 gaps). So 4 spaces per gap and 1 remainder.
#
############################################################
##
## discussion
##
############################################################
#
# We count the number of spaces first using s///g to replace all
# whitespace in a copy of the string. Then we remove all whitespace
# at the beginning of the string and at the end, so when splitting at
# whitespace, we only get back a list of words.
# If that list has at most one word, we return it with all whitespace
# appended at the end.
# Otherwise, we calculate the number of spaces per gap and the remaining
# whitespace after substracting all of the whitespaces that go into the
# gaps, then we piece together the final output from that.

use v5.36;

rearrange_spaces("  challenge  ");
rearrange_spaces("coding  is  fun");
rearrange_spaces("a b c  d");
rearrange_spaces("  team      pwc  ");
rearrange_spaces("   the  weekly  challenge  ");

sub rearrange_spaces($str) {
    say "Input: \"$str\"";
    my $tmp = $str;
    my $spaces = $tmp =~ s/\s//g;
    $str =~ s/^\s+//;
    $str =~ s/\s+$//;
    my @parts = split /\s+/, $str;
    if(scalar(@parts) <= 1) {
        return say "Output: \"" . join("", @parts) . ' 'x$spaces . "\"";
    }
    my $spaces_per_gap = int($spaces / ( scalar(@parts) - 1 ));
    $spaces -= $spaces_per_gap * ( scalar(@parts) - 1 );
    say "Output: \"" . join(' 'x$spaces_per_gap, @parts) . ' 'x$spaces . "\"";

}
