#!/usr/bin/env perl
#
=head1 Task 2: String Score

You are given a string, $str.

Write a script to return the score of the given string.

	The score of a string is defined as the sum of the absolute difference
	between the ASCII values of adjacent characters.

=head2 Example 1

	Input: $str = "hello"
	Output: 13

	ASCII values of characters:
	h = 104
	e = 101
	l = 108
	l = 108
	o = 111

	Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|
		  => 3 + 7 + 0 + 3
		  => 13

=head2 Example 2

	Input: "perl"
	Output: 30

	ASCII values of characters:
	p = 112
	e = 101
	r = 114
	l = 108

	Score => |112 - 101| + |101 - 114| + |114 - 108|
		  => 11 + 13 + 6
		  => 30

=head2 Example 3

	Input: "raku"
	Output: 37

	ASCII values of characters:
	r = 114
	a = 97
	k = 107
	u = 117

	Score => |114 - 97| + |97 - 107| + |107 - 117|
		  => 17 + 10 + 10
		  => 37

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	['hello', 13, 'Example 1'],
	['perl',  30, 'Example 2'],
	['raku',  37, 'Example 3'],
	['r',      0, 'Example 4'],
	['',       0, 'Example 5'],
];

sub string_score
{
	my $s = shift;

	my @s = split(//, $s);

	my $sum = 0;
	for my $i (1..$#s) {
		$sum += abs(ord($s[$i-1]) - ord($s[$i]));
	}

    return $sum;
}

for (@$cases) {
    is(string_score($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

