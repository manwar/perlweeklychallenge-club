#!/usr/bin/env perl
#
=head1 Task 1: Twice Appearance

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, containing lowercase English letters only.

Write a script to print the first letter that appears twice.

=head2 Example 1

	Input: $str = "acbddbca"
	Output: "d"

=head2 Example 2

	Input: $str = "abccd"
	Output: "c"

=head2 Example 3

	Input: $str = "abcdabbb"
	Output: "a"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	['acbddbca', 'd', 'Example 1'],
	['abccd',    'c', 'Example 2'],
	['abcdabbb', 'a', 'Example 3'],
];

sub twice_apperance
{
	my $str = shift;

	my %h;
	for my $c (split //, $str) {
		if (defined $h{$c}) {
			return $c;
		} else {
			$h{$c} = 1;
		}
	}
}

for (@$cases) {
    is(twice_apperance($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
