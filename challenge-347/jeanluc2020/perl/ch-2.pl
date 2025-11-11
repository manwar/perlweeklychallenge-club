#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-347/#TASK2
#
# Task 2: Format Phone Number
# ===========================
#
# You are given a phone number as a string containing digits, space and dash only.
#
# Write a script to format the given phone number using the below rules:
#
## 1. Removing all spaces and dashes
## 2. Grouping digits into blocks of length 3 from left to right
## 3. Handling the final digits (4 or fewer) specially:
##    - 2 digits: one block of length 2
##    - 3 digits: one block of length 3
##    - 4 digits: two blocks of length 2
## 4. Joining all blocks with dashes
#
## Example 1
##
## Input: $phone = "1-23-45-6"
## Output: "123-456"
##
##
## Example 2
##
## Input: $phone = "1234"
## Output: "12-34"
##
##
## Example 3
##
## Input: $phone = "12 345-6789"
## Output: "123-456-789"
##
##
## Example 4
##
## Input: $phone = "123 4567"
## Output: "123-45-67"
##
##
## Example 5
##
## Input: $phone = "123 456-78"
## Output: "123-456-78"
#
############################################################
##
## discussion
##
############################################################
#
# First, we remove all whitespace and dashes. Then, we fill an
# array with the first three digits, keeping the remainder, unless
# there are 4 or less digits left, in which case we pick either two
# times two, or the remaining 3 or 2 digits.

use v5.36;

format_phone_numbers("1-23-45-6");
format_phone_numbers("1234");
format_phone_numbers("12 345-6789");
format_phone_numbers("123 4567");
format_phone_numbers("123 456-78");

sub format_phone_numbers($phone) {
    say "Input: '$phone'";
    $phone =~ s/[\s-]*//g;
    my @parts = ();
    while(length($phone)) {
        if(length($phone) > 4) {
            push @parts, substr($phone, 0, 3, "");
        } elsif (length($phone) == 4) {
            push @parts, substr($phone, 0, 2, "");
            push @parts, $phone;
            $phone = "";
        } else {
            push @parts, $phone;
            $phone = "";
        }
    }
    say "Output: '" . join("-", @parts) . "'";
}
