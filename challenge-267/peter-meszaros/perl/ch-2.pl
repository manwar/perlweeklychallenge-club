#!/usr/bin/env perl
#
=head1 Task 2: Line Counts

You are given a string, $str, and a 26-items array @widths containing the width
of each character from a to z.

Write a script to find out the number of lines and the width of the last line
needed to display the given string, assuming you can only fit 100 width units
on a line.

=head2 Example 1

Input: $str = "abcdefghijklmnopqrstuvwxyz"

       @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)

Output: (3, 60)

Line 1: abcdefghij (100 pixels)

Line 2: klmnopqrst (100 pixels)

Line 3: uvwxyz (60 pixels)

=head2 Example 2

Input: $str = "bbbcccdddaaa"

       @widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)

Output: (2, 4)

Line 1: bbbcccdddaa (98 pixels)

Line 2: a (4 pixels)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[["abcdefghijklmnopqrstuvwxyz",
		 [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]],
     [3, 60]],
	[["bbbcccdddaaa",
		 [4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]],
     [2, 4]],
];

sub line_counts
{
	my $text = $_[0]->[0];
	my $widths = $_[0]->[1];

	my $length = 100;
	my $lines = 0;
	my $len = 0;
	for my $c (split '', $text) {
		my $w = $widths->[ord($c) - ord('a')];
		$len += $w;
		if ($len > 100) {
			++$lines;
			$len = $w;
		}
	}
	++$lines if $len > 0;
	return [$lines, $len];
}

for (@$cases) {
    is(line_counts($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

