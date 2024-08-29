#!/usr/bin/env perl

# Challenge 272
#
# Task 1: Defang IP Address
# Submitted by: Mohammad Sajid Anwar
# You are given a valid IPv4 address.
#
# Write a script to return the defanged version of the given IP address.
#
# A defanged IP address replaces every period “.” with “[.]".
#
# Example 1
# Input: $ip = "1.1.1.1"
# Output: "1[.]1[.]1[.]1"
# Example 2
# Input: $ip = "255.101.1.0"
# Output: "255[.]101[.]1[.]0"

use Modern::Perl;

$_ = shift // "";
say s/\./[.]/gr;
