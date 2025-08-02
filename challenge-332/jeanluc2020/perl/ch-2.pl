#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-332/#TASK2
#
# Task 2: Odd Letters
# ===================
#
# You are given a string.
#
# Write a script to find out if each letter in the given string appeared odd number of times.
#
## Example 1
##
## Input: $str = "weekly"
## Output: false
##
## w: 1 time
## e: 2 times
## k: 1 time
## l: 1 time
## y: 1 time
##
## The letter 'e' appeared 2 times i.e. even.
#
#
## Example 2
##
## Input: $str = "perl"
## Output: true
#
#
## Example 3
##
## Input: $source = "challenge"
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# We split the input into its individual characters and count
# each occurence by using a hash table. In the end, we check
# each letter whether it occurs an odd or even number of times.
# If any number occurs an even amount of times, we return false
# immediately. In the end, we can return true.

use v5.36;

odd_letters("weekly");
odd_letters("perl");
odd_letters("challenge");

sub odd_letters($str) {
    say "Input: \"$str\"";
    my $map = {};
    foreach my $l (split //, $str) {
        $map->{$l}++;
    }
    foreach my $l (keys %$map) {
        if( $map->{$l} % 2 == 0) {
            return say "Output: false";
        }
    }
    say "Output: true";
}
