#!/usr/bin/env perl
#
# You are given an array of strings and allowed string having distinct
# characters.
# 
#     A string is consistent if all characters in the string appear in the
#     string allowed.
# 
# 
# Write a script to return the number of consistent strings in the given array.
# Example 1
# 
# Input: @str = ("ad", "bd", "aaab", "baa", "badab")
#        $allowed = "ab"
# Output: 2
# 
# Strings "aaab" and "baa" are consistent since they only contain characters
# 'a' and 'b'.
# 
# Example 2
# 
# Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
#        $allowed = "abc"
# Output: 7
# 
# Example 3
# 
# Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
#        $allowed = "cad"
# Output: 4
# 
# Strings "cc", "acd", "ac", and "d" are consistent.
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[["ad", "bd", "aaab", "baa", "badab"], "ab"],
	[["a", "b", "c", "ab", "ac", "bc", "abc"], "abc"],
	[["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"], "cad"],
];

sub consistent_strings
{
	my ($strs, $allowed) = $_[0]->@*;

	my %allowed = map { $_ => 1} split('', $allowed);

	my $cnt = 0;
	WORD: for my $w (@$strs) {
		my @w = split('', $w);
		for my $c (@w) {
			next WORD unless exists $allowed{$c};
		}
		++$cnt;
	}

	return $cnt;
}

is(consistent_strings($cases->[0]), 2,  '[["ad", "bd", "aaab", "baa", "badab"], "ab"]');
is(consistent_strings($cases->[1]), 7,  '[["a", "b", "c", "ab", "ac", "bc", "abc"], "abc"]');
is(consistent_strings($cases->[2]), 4,  '[["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"], "cad"]');
done_testing();

exit 0;
