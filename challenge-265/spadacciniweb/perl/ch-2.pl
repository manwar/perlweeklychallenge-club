#!/usr/bin/env perl

# Task 2: Completing Word
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str containing alphnumeric characters and array of strings (alphabetic characters only), @str.
# 
# Write a script to find the shortest completing word. If none found return empty string.
# 
#     A completing word is a word that contains all the letters in the given string, ignoring space and number. If a letter appeared more than once in the given string then it must appear the same number or more in the word.
# 
# Example 1
# 
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
# 
# Example 2
# 
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
# 
# Example 3
# 
# Input: $str = 'JB 007'
#        @str = ('jj', 'bb', 'bjb')
# Output: 'bjb'
# 
# The given string contains following, ignoring case and number:
# j 1 times
# b 1 times
# 
# The only string in the given array that satisfies the condition is 'bjb'.

use strict;
use warnings;

my $str = 'aBc 11c';
my @str = ('accbbb', 'abc', 'abbc');
completing_word($str, \@str);

$str = 'Da2 abc';
@str = ('abcm', 'baacd', 'abaadc');
completing_word($str, \@str);

$str = 'JB 007';
@str = ('jj', 'bb', 'bjb');
completing_word($str, \@str);

exit 0;

sub completing_word {
    my $str = shift;
    my $strs = shift;

    my $str_lc = lc($str);
    my $return_str = '';
    $str_lc =~ s/\W|\d//g;
    my @strs = sort { (length $a) <=> (length $b) } @$strs;
    foreach my $strs (sort { (length $a) <=> (length $b) } @$strs) {
        my %freq;
        $freq{$_}++
            foreach split //, $strs;
        $freq{$_}--
            foreach split //, $str_lc;

        if ( scalar (map { $freq{$_} < 0 ? 1 : () } keys %freq) == 0) {
            $return_str = $strs;
            last;
        }
    }
    
    printf "'%s' ('%s') -> %s\n",
        $str,
        (join '\', \'', @$strs),
        $return_str;
}
