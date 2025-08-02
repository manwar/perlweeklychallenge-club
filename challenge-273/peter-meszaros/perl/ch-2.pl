#!/usr/bin/env perl
#
=head1 Task 2: B After A

You are given a string, $str.

Write a script to return true if there is at least one b, and no a appears
after the first b.

=head2 Example 1

	Input: $str = "aabb"
	Output: true

=head2 Example 2

	Input: $str = "abab"
	Output: false

=head2 Example 3

	Input: $str = "aaa"
	Output: false

=head2 Example 4

	Input: $str = "bbb"
	Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	['aabb', 1],
	['abab', 0],
	['aaa',  0],
	['bbb',  1],
];

sub b_after_a
{
	my $str = shift;

	return $str =~ m/^[^b]*b[^a]+$/ ? 1 : 0;
}

for (@$cases) {
    is(b_after_a($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

