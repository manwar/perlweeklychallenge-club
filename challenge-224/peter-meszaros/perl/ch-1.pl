#!/usr/bin/env perl
#
=head1 Task 1: Special Notes

You are given two strings, $source and $target.

Write a script to find out if using the characters (only once) from source, a
target string can be created.

=head2 Example 1

Input: $source = "abc"
       $target = "xyz"
Output: false

=head2 Example 2

Input: $source = "scriptinglanguage"
       $target = "perl"
Output: true

=head2 Example 3

Input: $source = "aabbcc"
       $target = "abc"
Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[["abc", "xyz"],                0],
	[["scriptinglanguage", "perl"], 1],
	[["aabbcc", "abc"],             1],
	[["aabbcc", "abbbc"],           0],
];

sub special_notes
{
	my $source = $_[0]->[0];
	my $target = $_[0]->[1];

	my %charset;
	++$charset{$_} for split '', $source;

	for my $c (split('', $target)) {
		return 0 if not defined $charset{$c} or $charset{$c} < 1;
		--$charset{$c};
	}
	return 1;
}

for (@$cases) {
    is(special_notes($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
