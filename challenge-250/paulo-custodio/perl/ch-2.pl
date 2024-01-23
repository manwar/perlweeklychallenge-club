#!/usr/bin/env perl

# Challenge 250
#
# Task 2: Alphanumeric String Value
# Submitted by: Mohammad S Anwar
#
# You are given an array of alphanumeric strings.
#
# Write a script to return the maximum value of alphanumeric string in the given array.
#
# The value of alphanumeric string can be defined as
#
# a) The numeric representation of the string in base 10 if it is made up of digits only.
# b) otherwise the length of the string
#
#
# Example 1
#
# Input: @alphanumstr = ("perl", "2", "000", "python", "r4ku")
# Output: 6
#
# "perl" consists of letters only so the value is 4.
# "2" is digits only so the value is 2.
# "000" is digits only so the value is 0.
# "python" consits of letters so the value is 6.
# "r4ku" consists of letters and digits so the value is 4.
#
# Example 2
#
# Input: @alphanumstr = ("001", "1", "000", "0001")
# Output: 1

use Modern::Perl;
use List::Util 'max';

say max(map {str_value($_)} @ARGV);

sub str_value {
    my($str) = @_;
    if ($str =~ /^\d+$/) {
        return 0+$str;
    }
    else {
        return length($str);
    }
}
