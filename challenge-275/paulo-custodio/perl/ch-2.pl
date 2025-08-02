#!/usr/bin/env perl

# Challenge 275
#
# Task 2: Replace Digits
# Submitted by: Mohammad Sajid Anwar
# You are given an alphanumeric string, $str, where each character is either a
# letter or a digit.
#
# Write a script to replace each digit in the given string with the value of the previous letter plus (digit) places.
#
# Example 1
# Input: $str = 'a1c1e1'
# Ouput: 'abcdef'
#
# shift('a', 1) => 'b'
# shift('c', 1) => 'd'
# shift('e', 1) => 'f'
# Example 2
# Input: $str = 'a1b2c3d4'
# Output: 'abbdcfdh'
#
# shift('a', 1) => 'b'
# shift('b', 2) => 'd'
# shift('c', 3) => 'f'
# shift('d', 4) => 'h'
# Example 3
# Input: $str = 'b2b'
# Output: 'bdb'
# Example 4
# Input: $str = 'a16z'
# Output: 'abgz'

use Modern::Perl;

$_ = shift // "";
1 while s/([^\d])(\d+)/ expand($1, $2) /e;
say $_;

sub expand {
    my($ch, $digits) = @_;
    my $out = $ch;
    for my $digit (split //, $digits) {
        $out .= chr(ord($ch)+$digit);
    }
    return $out;
}
