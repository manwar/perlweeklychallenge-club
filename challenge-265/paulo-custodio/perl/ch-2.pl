#!/usr/bin/env perl

# Challenge 265
#
# Task 2: Completing Word
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str containing alphnumeric characters and array of
# strings (alphabetic characters only), @str.
#
# Write a script to find the shortest completing word. If none found return
# empty string.
#
# A completing word is a word that contains all the letters in the given string,
# ignoring space and number. If a letter appeared more than once in the given
# string then it must appear the same number or more in the word.
#
# Example 1
# Input: $str = 'aBc 11c'
#        @str = ('accbbb', 'abc', 'abbc')
# Output: 'accbbb'
#
# The given string contains following, ignoring case and number:
# a 1 times
# b 1 times
# c 2 times
#
# The only string in the given array that satisfies the condition is 'accbbb'.
# Example 2
# Input: $str = 'Da2 abc'
#        @str = ('abcm', 'baacd', 'abaadc')
# Output: 'baacd'
#
# The given string contains following, ignoring case and number:
# a 2 times
# b 1 times
# c 1 times
# d 1 times
#
# The are 2 strings in the given array that satisfies the condition:
# 'baacd' and 'abaadc'.
#
# Shortest of the two is 'baacd'
# Example 3
# Input: $str = 'JB 007'
#        @str = ('jj', 'bb', 'bjb')
# Output: 'bjb'
#
# The given string contains following, ignoring case and number:
# j 1 times
# b 1 times
#
# The only string in the given array that satisfies the condition is 'bjb'.

use Modern::Perl;

my($str, @words) = @ARGV;

my @result =
        sort {length($a) <=> length($b)}
        grep {is_completing($str, $_)} @words;
say @result ? $result[0] : "''";


sub is_completing {
    my($str, $word) = @_;
    $str =~ s/[^a-z]//gi;
    my %count; $count{lc($_)}++ for split //, $str;
    $word = join '', sort split //, $word;
    while (my($ch, $count) = each %count) {
        my $code = '$word =~ s/'.$ch.'{'.$count.',}//i';
        eval($code) or return 0;
    }
    return $word eq '';
}
