#!/usr/bin/env perl

# Challenge 216
#
# Task 1: Registration Number
# Submitted by: Mohammad S Anwar
#
# You are given a list of words and a random registration number.
#
# Write a script to find all the words in the given list that has every letter
# in the given registration number.
#
# Example 1
#
# Input: @words = ('abc', 'abcd', 'bcd'), $reg = 'AB1 2CD'
# Output: ('abcd')
#
# The only word that matches every alphabets in the given registration number
# is 'abcd'.
#
# Example 2
#
# Input: @words = ('job', 'james', 'bjorg'), $reg = '007 JB'
# Output: ('job', 'bjorg')
#
# Example 3
#
# Input: @words = ('crack', 'road', 'rac'), $reg = 'C7 RA2'
# Output: ('crack', 'rac')

use Modern::Perl;

sub has_every_letter {
    my($word, $reg) = @_;
    $reg =~ s/\s+//g;
    $reg =~ s/0/o/g;
    $reg =~ s/\d+//g;
    for my $letter (split //, $word) {
        $reg =~ s/$letter//gi;
    }
    return $reg eq '';
}

my($reg, @words) = @ARGV;
say join ", ", grep {has_every_letter($_, $reg)} @words;
