#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-317/#TASK1
#
# Task 1: Acronyms
# ================
#
# You are given an array of words and a word.
#
# Write a script to return true if concatenating the first letter of each word
# in the given array matches the given word, return false otherwise.
#
## Example 1
##
## Input: @array = ("Perl", "Weekly", "Challenge")
##        $word  = "PWC"
## Output: true
#
#
## Example 2
##
## Input: @array = ("Bob", "Charlie", "Joe")
##        $word  = "BCJ"
## Output: true
#
#
## Example 3
##
## Input: @array = ("Morning", "Good")
##        $word  = "MM"
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# This is actually a oneliner. We need to compare $word to
# the output of join("", map {substr($_,0,1)} @array)
# join("", ...) turns a list of strings into the concatenated
# string. The strings we want to concatenate are the first
# characters of all word in @array, which the map {...} @array
# part does by selecting the first character of each element via
# substr(). If the concatenated string is equal to $word, we
# can return true, otherwise false.

use v5.36;

acronyms("PWC", "Perl", "Weekly", "Challenge");
acronyms("BCJ", "Bob", "Charlie", "Joe");
acronyms("MM", "Morning", "Good");

sub acronyms($word, @array) {
    say "Input: word '$word', array (\"" . join("\", \"", @array) . "\")";
    if(join("", map {substr($_,0,1)} @array) eq $word) {
        say "Output: true";
    } else {
        say "Output: false";
    }
}
