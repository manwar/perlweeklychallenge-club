#!/usr/bin/env perl
# You are given a list of words.
# 
# Write a script to return the list of common characters (sorted alphabeticall) found in every word of the given list.
# Example 1
# 
# Input: @words = ("Perl", "Rust", "Raku")
# Output: ("r")
# 
# Example 2
# 
# Input: @words = ("love", "live", "leave")
# Output: ("e", "l", "v")

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	["Perl", "Rust", "Raku"],
	["love", "live", "leave"],
];

sub common_characters
{
	my $l = shift;

    my %h;
	for (@$l) {
		++$h{$_} for (split('', lc));
	}
    my $len = @$l;
	my @r;
	for (keys %h) {
		push @r, $_ if $h{$_} >= $len;
	}
	@r = sort @r;

    return \@r;
}

is_deeply(common_characters($cases->[0]), ["r"],           '["Perl", "Rust", "Raku"]');
is_deeply(common_characters($cases->[1]), ["e", "l", "v"], '["love", "live", "leave"]');
done_testing();

exit 0;
