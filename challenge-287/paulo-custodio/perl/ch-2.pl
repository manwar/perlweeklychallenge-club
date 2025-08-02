#!/usr/bin/env perl

# Challenge 287
#
# Task 2: Valid Number
# Submitted by: Mohammad Sajid Anwar
#
# You are given a string, $str.
#
# Write a script to find if it is a valid number.
#
# Conditions for a valid number:
#
# - An integer number followed by an optional exponent.
# - A decimal number followed by an optional exponent.
# - An integer number is defined with an optional sign '-' or '+' followed by digits.
#
# Decimal Number:
#
# A decimal number is defined with an optional sign '-' or '+' followed by one
# of the following definitions:
# - Digits followed by a dot '.'.
# - Digits followed by a dot '.' followed by digits.
# - A dot '.' followed by digits.
#
# Exponent:
#
# An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.
#
# Example 1
#
# Input: $str = "1"
# Output: true
#
# Example 2
#
# Input: $str = "a"
# Output: false
#
# Example 3
#
# Input: $str = "."
# Output: false
#
# Example 4
#
# Input: $str = "1.2e4.2"
# Output: false
#
# Example 5
#
# Input: $str = "-1."
# Output: true
#
# Example 6
#
# Input: $str = "+1E-8"
# Output: true
#
# Example 7
#
# Input: $str = ".44"
# Output: true

use Modern::Perl;

$_ = shift // "";
say /^ [-+]?
       (?: \d+ \. \d* |
           \d* \. \d+ |
           \d+
       )
       (?: e [-+]? \d+ )?
    $/ix ? "true" : "false";
