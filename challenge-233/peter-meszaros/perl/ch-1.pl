#!/usr/bin/env perl

# You are given an array of words made up of alphabets only.
# 
# Write a script to find the number of pairs of similar words. Two words are
# similar if they consist of the same characters.
#
# Example 1
# 
# Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
# Output: 2
# 
# Pair 1: similar words ("aba", "aabb")
# Pair 2: similar words ("bac", "aabc")
# 
# Example 2
# 
# Input: @words = ("aabb", "ab", "ba")
# Output: 3
# 
# Pair 1: similar words ("aabb", "ab")
# Pair 2: similar words ("aabb", "ba")
# Pair 3: similar words ("ab", "ba")
# 
# Example 3
# 
# Input: @words = ("nba", "cba", "dba")
# Output: 0
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;
use List::MoreUtils qw(uniq);
use List::Util qw(reduce);

my $cases = [
    ["aba", "aabb", "abcd", "bac", "aabc"],
    ["aabb", "ab", "ba"],
    ["nba", "cba", "dba"],
];

sub similar_words
{
    my $l = shift;
    
    my %h;
	for my $w (@$l) {
		++$h{join('', sort(uniq(split('', $w))))};
	}
    my $cnt = 0;
    for my $l (keys %h) {
		my $v = $h{$l};
        if ($v > 1) {
            my $n += reduce { $a * $b } 1 .. $v; # n!
            my $nk += ($v == 2 ? 1 : reduce { $a * $b } 1 .. ($v - 2)); # (n-k)!
            $cnt += $n / (2 * $nk); # n!/k!(n-k)!
        }
    }
	return $cnt; 
}

is(similar_words($cases->[0]), 2, '["aba", "aabb", "abcd", "bac", "aabc"]');
is(similar_words($cases->[1]), 3, '["aabb", "ab", "ba"]');
is(similar_words($cases->[2]), 0, '["nba", "cba", "dba"]');
done_testing();

exit 0;
