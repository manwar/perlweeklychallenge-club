#!/usr/bin/env perl
#
#
# You are given a string, $str containing alphnumeric characters and array of
# strings (alphabetic characters only), @str.
# 
# Write a script to find the shortest completing word. If none found return
# empty string.
# 
#     A completing word is a word that contains all the letters in the given
#     string, ignoring space and number. If a letter appeared more than once in
#     the given string then it must appear the same number or more in the word.
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
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [['aBc 11c', ['accbbb', 'abc', 'abbc']],   'accbbb', 'Example 1'],
    [['Da2 abc', ['abcm', 'baacd', 'abaadc']], 'baacd',  'Example 2'],
    [['JB 007',  ['jj', 'bb', 'bjb']],         'bjb',    'Example 3'],
];

sub completing_word
{
    my $str = $_[0]->[0];
    my $lst = $_[0]->[1];

    my %str;
    $str{lc $_}++ for (grep { /[a-z]/i } split(//, $str));

    my @res;
    NEXTWORD: for my $l (@$lst) {
        my %l;
        $l{$_}++ for (split(//, $l));

        for my $k (keys %str) {
            next NEXTWORD if (not defined $l{$k}) || ($str{$k} > $l{$k});
        }
        push @res, $l;
    }

    return (sort { length($a) <=> length($b) } @res)[0];
}

for (@$cases) {
    is(completing_word($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

