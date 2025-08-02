#!/usr/bin/env perl

# Challenge 231
#
# Task 2: Senior Citizens
# Submitted by: Mohammad S Anwar
# You are given a list of passenger details in the form “9999999999A1122”, where
# 9 denotes the phone number, A the sex, 1 the age and 2 the seat number.
#
# Write a script to return the count of all senior citizens (age >= 60).
#
# Example 1
# Input: @list = ("7868190130M7522","5303914400F9211","9273338290F4010")
# Ouput: 2
#
# The age of the passengers in the given list are 75, 92 and 40.
# So we have only 2 senior citizens.
# Example 2
# Input: @list = ("1313579440F2036","2921522980M5644")
# Ouput: 0

use Modern::Perl;

say scalar grep {age($_) >= 60} @ARGV;

sub age {
    my($record) = @_;
    my $age = 0+substr($record, 11, 2);
    return $age;
}
