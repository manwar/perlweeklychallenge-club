#!/usr/bin/env perl
#
# You are given two strings, $str1 and $str2.
# 
# Write a script to merge the given strings by adding in alternative order
# starting with the first string. If a string is longer than the other then
# append the remaining at the end.
# Example 1
# 
# Input: $str1 = "abcd", $str2 = "1234"
# Output: "a1b2c3d4"
# 
# Example 2
# 
# Input: $str1 = "abc", $str2 = "12345"
# Output: "a1b2c345"
# 
# Example 3
# 
# Input: $str1 = "abcde", $str2 = "123"
# Output: "a1b2c3de"
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[ "abcd",  "1234"],
	[ "abc",   "12345"],
	[ "abcde", "123"],
];

sub merge_strings
{
	my ($str1, $str2) = @_;
	
	my @arr1 = split //, $str1;
	my @arr2 = split //, $str2;
    my $len = @arr1 > @arr2 ? @arr1 : @arr2;

    my @res;
    for my $i (0..$len) {
		push @res, $arr1[$i] // '', $arr2[$i] // '';
	}	
	return join '', @res;
}

is(merge_strings($cases->[0]->@*), "a1b2c3d4", 'Example 1');
is(merge_strings($cases->[1]->@*), "a1b2c345", 'Example 2');
is(merge_strings($cases->[2]->@*), "a1b2c3de", 'Example 3');
done_testing();

exit 0;

