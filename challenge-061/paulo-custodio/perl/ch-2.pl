#!/usr/bin/env perl

# Challenge 061
#
# TASK #2 › IPv4 Partition
# Reviewed by: Ryan Thompson
# You are given a string containing only digits (0..9). The string should have
# between 4 and 12 digits.
#
# Write a script to print every possible valid IPv4 address that can be made by
# partitioning the input string.
#
# For the purpose of this challenge, a valid IPv4 address consists of four
# “octets” i.e. A, B, C and D, separated by dots (.).
#
# Each octet must be between 0 and 255, and must not have any leading zeroes.
# (e.g., 0 is OK, but 01 is not.)
#
# Example
# Input: 25525511135,
#
# Output:
#
# 255.255.11.135
# 255.255.111.35

use Modern::Perl;

my $digits = shift;
partition("", $digits);


sub partition {
    my($prefix, $digits) = @_;
    if ($prefix =~ /^(\d+\.){4}$/ && $digits eq '') {
        $prefix =~ s/\.$//;
        say $prefix;
    }
    else {
        for my $len (1..3) {
            next if $len > length($digits);
            my $part = substr($digits, 0, $len);
            next if $part > 255;
            partition($prefix.$part.".", substr($digits, $len));
        }
    }
}
