#!/usr/bin/env perl
#
=head1 Task 2: Split String

Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to split the given string into two containing exactly same
number of vowels and return true if you can otherwise false.

=head2 Example 1

	Input: $str = "perl"
	Ouput: false

=head2 Example 2

	Input: $str = "book"
	Ouput: true

Two possible strings "bo" and "ok" containing exactly one vowel each.

=head2 Example 3

	Input: $str = "good morning"
	Ouput: true

Two possible strings "good " and "morning" containing two vowels each or
"good m" and "orning" containing two vowels each.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

use constant true  => 1;
use constant false => 0;

my $cases = [
	["perl",         false],
	["book",         true],
	["good morning", true],
];

my $wovels = {
	a => 1,
	e => 1,
	i => 1,
	o => 1,
	u => 1,
};

sub split_string
{
	my $str = shift;

	return ((grep {$wovels->{$_}} split '', $str) % 2) ? false : true;
}

for (@$cases) {
    is(split_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

