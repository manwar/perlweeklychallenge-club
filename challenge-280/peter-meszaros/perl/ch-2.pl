#!/usr/bin/env perl
#
=head1 Task 2: Count Asterisks

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, where every two consecutive vertical bars are
grouped into a pair.

Write a script to return the number of asterisks, *, excluding any between each
pair of vertical bars.

=head2 Example 1

	Input: $str = "p|*e*rl|w**e|*ekly|"
	Ouput: 2

The characters we are looking here are "p" and "w**e".

=head2 Example 2

	Input: $str = "perl"
	Ouput: 0

=head2 Example 3

	Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
	Ouput: 5

The characters we are looking here are "th", "e**", "l***ych" and "e".

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;


my $cases = [
	['p|*e*rl|w**e|*ekly|',           2, 'Example 1'],
	['perl',                          0, 'Example 2'],
	['th|ewe|e**|k|l***ych|alleng|e', 5, 'Example 3'],
];

sub count_asterisks
{
	my $str = shift;

	my @str = split(/\|/, $str);
	$str = join '', @str[grep { not $_ % 2 } 0 .. $#str];
	return $str =~ tr/*//;
}

for (@$cases) {
    is(count_asterisks($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

