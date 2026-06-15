#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-378/#TASK1
#
# Task 1: Second Largest Digit
# ============================
#
# You are given an alphanumeric string.
#
# Write a script to find the second largest distinct digit in the given string.
# Return -1 if none found.
#
## Example 1
##
## Input: $str = "aaaaa77777"
## Output: -1
##
## The only digit in the given string is 7 and there is no second digit.
#
## Example 2
##
## Input: $str = "abcde"
## Output: -1
##
## No numerical digits in the given string.
#
## Example 3
##
## Input: $str = "9zero8eight7seven9"
## Output: 8
#
## Example 4
##
## Input: $str = "xyz9876543210"
## Output: 8
#
## Example 5
##
## Input: $str = "4abc4def2ghi8jkl2"
## Output: 4
#
############################################################
##
## discussion
##
############################################################
#
# We collect all found digits in a hash, then use that to create
# a sorted array from those found digits to fill then into an array.
# Then we pick the second element from that array, but only if there
# are enough. Otherwise, we fail with a return of "-1".

use v5.36;

second_largest_digit("aaaaa77777");
second_largest_digit("abcde");
second_largest_digit("9zero8eight7seven9");
second_largest_digit("xyz9876543210");
second_largest_digit("4abc4def2ghi8jkl2");

sub second_largest_digit($str) {
    say "Input: \"$str\"";
    my $digits = {};
    foreach my $c (split //, $str) {
        next unless $c =~ m/\d/;
        $digits->{$c} = 1;
    }
    my @found_digits = sort { $b <=> $a } keys %$digits;
    if ( scalar(@found_digits) < 2 ) {
        say "Output: -1";
    } else {
        say "Output: $found_digits[1]";
    }
}
