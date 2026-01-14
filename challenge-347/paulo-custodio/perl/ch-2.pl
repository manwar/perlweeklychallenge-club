#!/usr/bin/env perl

# Challenge 347
#
# Task 2: Format Phone Number
# Submitted by: Mohammad Sajid Anwar
# You are given a phone number as a string containing digits, space and dash only.
#
# Write a script to format the given phone number using the below rules:
#
# 1. Removing all spaces and dashes
# 2. Grouping digits into blocks of length 3 from left to right
# 3. Handling the final digits (4 or fewer) specially:
#    - 2 digits: one block of length 2
#    - 3 digits: one block of length 3
#    - 4 digits: two blocks of length 2
# 4. Joining all blocks with dashes
#
# Example 1
# Input: $phone = "1-23-45-6"
# Output: "123-456"
#
# Example 2
# Input: $phone = "1234"
# Output: "12-34"
#
# Example 3
# Input: $phone = "12 345-6789"
# Output: "123-456-789"
#
# Example 4
# Input: $phone = "123 4567"
# Output: "123-45-67"
#
# Example 5
# Input: $phone = "123 456-78"
# Output: "123-456-78"

use Modern::Perl;

@ARGV or die "usage: $0 phone-num\n";
say format_phone("@ARGV");

sub format_phone {
    my($num) = @_;
    my @out;
    $num =~ s/\D//g;
    while ($num ne '') {
        if (length($num) <= 2) {
            push @out, $num;
            $num = '';
        }
        elsif (length($num) == 4) {
            push @out, substr($num, 0, 2), substr($num, 2, 2);
            $num = '';
        }
        else {
            push @out, substr($num, 0, 3);
            $num = substr($num, 3);
        }
    }
    return join("-", @out);
}
