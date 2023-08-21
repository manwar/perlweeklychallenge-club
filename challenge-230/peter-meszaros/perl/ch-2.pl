#!/usr/bin/env perl

# You are given an array of words made up of alphabetic characters and a prefix.
# 
# Write a script to return the count of words that starts with the given prefix.
# Example 1
# 
# Input: @words  = ("pay", "attention", "practice", "attend")
#        $prefix = "at"
# Ouput: 2
# 
# Two words "attention" and "attend" starts with the given prefix "at".
# 
# Example 2
# 
# Input: @words  = ("janet", "julia", "java", "javascript")
#        $prefix = "ja"
# Ouput: 3
# 
# Three words "janet", "java" and "javascripr" starts with the given prefix "ja".

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
    [["pay", "attention", "practice", "attend"], "at"],
    [["janet", "julia", "java", "javascript"],   "ja"],
];

sub count_words
{
    my ($arr, $prefix) = ($_[0]->[0], $_[0]->[1]);

    my $cnt = 0;
    my $prefreg = qr/^$prefix/;

	for (@$arr) {
		++$cnt if /$prefreg/;
	}

    return $cnt;
}

is(count_words($cases->[0]), 2, '["pay", "attention", "practice", "attend"], "at"');
is(count_words($cases->[1]), 3, '["janet", "julia", "java", "javascript"], "ja"');
done_testing();

exit 0;
