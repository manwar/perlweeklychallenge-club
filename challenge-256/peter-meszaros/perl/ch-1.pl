#!/usr/bin/env perl
#
# You are given an array of distinct words, @words.
# 
# Write a script to find the maximum pairs in the given array. The words
# $words[i] and $words[j] can be a pair one is reverse of the other.
# Example 1
# 
# Input: @words = ("ab", "de", "ed", "bc")
# Output: 1
# 
# There is one pair in the given array: "de" and "ed"
# 
# Example 2
# 
# Input: @words = ("aa", "ba", "cd", "ed")
# Output: 0
# 
# Example 3
# 
# Input: @words = ("uv", "qp", "st", "vu", "mn", "pq"))
# Output: 2
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	["ab", "de", "ed", "bc"],
	["aa", "ba", "cd", "ed"],
	["uv", "qp", "st", "vu", "mn", "pq"],
];

sub maximum_pairs
{
	my $pairs = shift;

	my %h = map { $_, 1 } @$pairs;
    my $numpairs = 0;
    for my $e (@$pairs) {
        delete $h{$e};
        ++$numpairs if $h{reverse $e};
	}
	return $numpairs;
}

is(maximum_pairs($cases->[0]), 1, 'Example 1');
is(maximum_pairs($cases->[1]), 0, 'Example 2');
is(maximum_pairs($cases->[2]), 2, 'Example 3');
done_testing();

exit 0;
