#!/usr/bin/env perl
#
# You are given an array of strings and a character separator.
# 
# Write a script to return all words separated by the given character excluding
# empty string.
# Example 1
# 
# Input: @words = ("one.two.three","four.five","six")
#        $separator = "."
# Output: "one","two","three","four","five","six"
# 
# Example 2
# 
# Input: @words = ("$perl$$", "$$raku$")
#        $separator = "$"
# Output: "perl","raku"

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[['one.two.three', 'four.five', 'six'], '.'],
	[['$perl$$', '$$raku$'], '$'],
];

sub split_string
{
	my $list = shift;
	my $sep = shift;

    my $res;
    my $s = "\\$sep";
    for my $l (@$list) {
        $l =~ s/$s/ /g;
        push @$res, split(' ', $l);
    }
    return $res;
}

is(split_string($cases->[0]->@*),
                ['one', 'two', 'three', 'four', 'five', 'six'],
                'Example 1');
is(split_string($cases->[1]->@*),
                 ['perl', 'raku'],
                 'Example 2');
done_testing();

exit 0;
