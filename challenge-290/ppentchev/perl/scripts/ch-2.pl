#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use Test::More;

use constant TEST_SEQUENCES => [
	# The test strings from the problem
	['17893729974', 1],
	['4137 8947 1175 5904', 1],
	['4137 8974 1175 5904', 0],

	# Let's start simple...
	['00', 1],
	['01', 0],
	['05', 0],
	['18', 1],
	['19', 0],
	['11', 0],
	['59', 1],
	['50', 0],
	['67', 1],
	['66', 0],

	# Now make sure we can ignore extraneous characters
	[' ?23a#2 :)', 1],
	[' ?32a#2 :)', 0],
	['a0b1c2d3e4f5g6h7i8j9k0', 0],
	['a0b1c2d3e4f5g6h7i8j9k1', 0],
	['a0b1c2d3e4f5g6h7i8j9k2', 0],
	['a0b1c2d3e4f5g6h7i8j9k3', 0],
	['a0b1c2d3e4f5g6h7i8j9k4', 0],
	['a0b1c2d3e4f5g6h7i8j9k5', 0],
	['a0b1c2d3e4f5g6h7i8j9k6', 0],
	['a0b1c2d3e4f5g6h7i8j9k7', 1],
	['a0b1c2d3e4f5g6h7i8j9k8', 0],
	['a0b1c2d3e4f5g6h7i8j9k9', 0],
];

sub gather_digits($)
{
	my ($str) = @_;

	my @res;
	while ($str =~ /([0-9])/g) {
		push @res, int $1;
	}
	return @res;
}

sub luhn_check($)
{
	my ($str) = @_;
	my @digits = gather_digits reverse $str;
	return 0 unless @digits;

	my $cksum = shift @digits;
	my $sum = 0;
	my $double = 1;
	for my $digit (@digits) {
		my $value = $double ? $digit * 2 : $digit;
		$double = !$double;

		if ($value > 9) {
			$sum += $value - 9;
		} else {
			$sum += $value;
		}
	}

	return (($sum + $cksum) % 10) == 0 ? 1 : 0;
}

plan tests => 1;

subtest 'Test the luhn_check() function' => sub {
	plan tests => scalar @{TEST_SEQUENCES()};
	for my $tcase (@{TEST_SEQUENCES()}) {
		my ($str, $expected) = @{$tcase};
		is $expected, luhn_check $str;
	}
};
