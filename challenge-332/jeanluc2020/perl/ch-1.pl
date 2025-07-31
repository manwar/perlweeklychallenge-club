#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-332/#TASK1
#
# Task 1: Binary Date
# ===================
#
# You are given a date in the format YYYY-MM-DD.
#
# Write a script to convert it into binary date.
#
# Example 1
#
# Input: $date = "2025-07-26"
# Output: "11111101001-111-11010"
#
#
# Example 2
#
# Input: $date = "2000-02-02"
# Output: "11111010000-10-10"
#
#
# Example 3
#
# Input: $date = "2024-12-31"
# Output: "11111101000-1100-11111"
#
############################################################
##
## discussion
##
############################################################
#
# We split the date into its single parts, then we create the
# binary representation for all of those and put them together
# again in the end.
# To turn a number into its binary representation, we just check
# wether it is even or not so we know whether the last digit will
# be a "1" or a "0", and append that to the binary representation
# of the integer value of the number divided by 2. Of course we
# return an empty string in case of an input of "0" to stop
# processing.

use v5.36;

binary_date("2025-07-26");
binary_date("2000-02-02");
binary_date("2024-12-31");


sub binary_date($date) {
    say "Input: \"$date\"";
    my @numbers = split /-/, $date;
    my @binary_numbers = ();
    foreach my $num (@numbers) {
        push @binary_numbers, binary($num);
    }
    my $binary_date = join("-", @binary_numbers);
    say "Output: \"$binary_date\"";
}

sub binary($decimal) {
    if($decimal > 0) {
        if($decimal % 2) {
            return binary(int($decimal/2)) . "1";
        } else {
            return binary(int($decimal/2)) . "0";
        }
    }
    return "";
}

