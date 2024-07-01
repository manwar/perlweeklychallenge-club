#!/usr/bin/env perl
#
=head1 Task 2: Replace Digits

You are given an alphanumeric string, $str, where each character is either a
letter or a digit.

Write a script to replace each digit in the given string with the value of the
previous letter plus (digit) places.

=head2 Example 1

	Input: $str = 'a1c1e1'
	Ouput: 'abcdef'

	shift('a', 1) => 'b'
	shift('c', 1) => 'd'
	shift('e', 1) => 'f'

=head2 Example 2

	Input: $str = 'a1b2c3d4'
	Output: 'abbdcfdh'

	shift('a', 1) => 'b'
	shift('b', 2) => 'd'
	shift('c', 3) => 'f'
	shift('d', 4) => 'h'

=head2 Example 3

	Input: $str = 'b2b'
	Output: 'bdb'

=head2 Example 4

	Input: $str = 'a16z'
	Output: 'abgz'

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	['a1c1e1',   'abcdef'],
	['a1b2c3d4', 'abbdcfdh'],
	['b2b',      'bdb'],
	['a16z',     'abgz'],
	['816z',     undef],
];

sub replace_digits
{
	my $str = shift;

	my @str = split //, $str;
    return undef if $str[0] =~ /\d/;
	my $c = ord($str[0]);
    for my $i (1..$#str) {
		if ($str[$i] =~ /\d/) {
			$str[$i] = chr($c+$str[$i]);
		} else {
			$c = ord($str[$i]);
		}
	}
	return join '', @str;
}

for (@$cases) {
    is(replace_digits($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

