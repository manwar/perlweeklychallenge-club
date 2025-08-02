#!/usr/bin/env perl

# Task 2: Replace Digits
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an alphanumeric string, $str, where each character is either a letter or a digit.
# Write a script to replace each digit in the given string with the value of the previous letter plus (digit) places.
# 
# Example 1
# Input: $str = 'a1c1e1'
# Ouput: 'abcdef'
# 
# shift('a', 1) => 'b'
# shift('c', 1) => 'd'
# shift('e', 1) => 'f'
# 
# Example 2
# Input: $str = 'a1b2c3d4'
# Output: 'abbdcfdh'
# 
# shift('a', 1) => 'b'
# shift('b', 2) => 'd'
# shift('c', 3) => 'f'
# shift('d', 4) => 'h'
# 
# Example 3
# Input: $str = 'b2b'
# Output: 'bdb'
# 
# Example 4
# Input: $str = 'a16z'
# Output: 'abgz'

use strict;
use warnings;

my $str = 'a1c1e1';
replace_digits($str);

$str = 'a1b2c3d4';
replace_digits($str);

$str = 'b2b';
replace_digits($str);

$str = 'a16z';
replace_digits($str);

exit 0;

sub replace_digits {
    my $str = shift;

    my $char = '';
    my $new_str = join '', map {
                             my $curr_char = ($_ =~ /[0-9]/)
                                 ? chr(ord($char)+$_)
                                 : $_;
                             $char = $curr_char;
                           } split //, $str;
    printf "'%s' -> '%s'\n",
        $str,
        $new_str;
}
