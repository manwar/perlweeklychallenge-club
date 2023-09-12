#!/usr/bin/env perl
#
# You are given an array of words made up of alphabetic characters only.
# 
# Write a script to return all alphabetic characters that show up in all words
# including duplicates.
# Example 1
# 
# Input: @words = ("java", "javascript", "julia")
# Output: ("j", "a")
# 
# Example 2
# 
# Input: @words = ("bella", "label", "roller")
# Output: ("e", "l", "l")
# 
# Example 3
# 
# Input: @words = ("cool", "lock", "cook")
# Output: ("c", "o")
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
    ["java", "javascript", "julia"],
    ["bella", "label", "roller"],
    ["cool", "lock", "cook"],
];

sub common_characters
{
	my $l = shift;

    my $word = shift @$l;
    my $len = @$l;
	my @word = split('', $word);
    my @res;

    for my $c (@word) {
		my $cnt = 0;
		for my $w (@$l) {
			++$cnt if $w =~ s/$c//;
		}
		push @res, $c if $cnt == $len;
	}

	return \@res;
}

is_deeply(common_characters($cases->[0]), ["j", "a"],      '["java", "javascript", "julia"]');
is_deeply(common_characters($cases->[1]), ["e", "l", "l"], '["bella", "label", "roller"]');
is_deeply(common_characters($cases->[2]), ["c", "o"],      '["cool", "lock", "cook"]');
done_testing();

exit 0;
