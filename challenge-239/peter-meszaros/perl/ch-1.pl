#!/usr/bin/env perl
#
# You are given two arrays of strings.
# 
# Write a script to find out if the word created by concatenating the array
# elements is the same.
# Example 1
# 
# Input: @arr1 = ("ab", "c")
#        @arr2 = ("a", "bc")
# Output: true
# 
# Using @arr1, word1 => "ab" . "c" => "abc"
# Using @arr2, word2 => "a" . "bc" => "abc"
# 
# Example 2
# 
# Input: @arr1 = ("ab", "c")
#        @arr2 = ("ac", "b")
# Output: false
# 
# Using @arr1, word1 => "ab" . "c" => "abc"
# Using @arr2, word2 => "ac" . "b" => "acb"
# 
# Example 3
# 
# Input: @arr1 = ("ab", "cd", "e")
#        @arr2 = ("abcde")
# Output: true
# 
# Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
# Using @arr2, word2 => "abcde"
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
    [["ab", "c"], ["a", "bc"]],
    [["ab", "c"], ["ac", "b"]],
    [["ab", "cd", "e"], ["abcde"]],
];

sub same_string
{
	my ($arr1, $arr2) = $_[0]->@*;

	my $w1 = join('', @$arr1);
	my $w2 = join('', @$arr2);
    return $w1 eq $w2 ? 1 : 0;
}

is(same_string($cases->[0]), 1, '[["ab", "c"], ["a", "bc"]]');
is(same_string($cases->[1]), 0, '[["ab", "c"], ["ac", "b"]]');
is(same_string($cases->[2]), 1, '[["ab", "cd", "e"], ["abcde"]]');
done_testing();

exit 0;


