#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use Test::More;

use constant TEST_SEQUENCES => [
	# The test sequences from the problem
	[[6, 2, 2, 3], 1],
	[[3, 1, 4, 13], 0],
	[[2, 1, 4, 2], 1],

	# Let's start simple...
	[[], 0],
	[[0], 0],
	[[0, 0], 1],
	[[0, 1], 0],
	[[1, 0, 0], 1],
	[[2, 0, 1], 1],

	# ...and work our way towards some more complex cases
	[[1, 2, 3, 4], 1],
	[[1, 2, 3, 5], 1],
	[[1, 3, 4, 5], 0],

	# Make sure we don't mix doubles and halves
	[[1, 4], 0],
	[[1, 2, 4], 1],
];

# This function will eat up quite a lot of memory for large sets
sub doubles_exist($)
{
	my ($seq) = @_;
	my %seen;

	for my $value (@{$seq}) {
		my $double = $value * 2;
		return 1 if $seen{$double};

		if (($value % 2) == 0) {
			my $half = $value / 2;
			return 1 if $seen{$half};
		}

		$seen{$value} = 1;
	}
	return 0;
}

# This function may eat up... considerably more memory if the set of numbers is quite sparse
sub doubles_exist_vec($)
{
	my ($seq) = @_;
	my $seen = '';

	for my $value (@{$seq}) {
		my $double = $value * 2;
		return 1 if vec($seen, $double, 1);

		if (($value % 2) == 0) {
			my $half = $value / 2;
			return 1 if vec($seen, $half, 1);
		}

		vec($seen, $value, 1) = 1;
	}
	return 0;
}

plan tests => 2;

subtest 'Test the doubles_exist() function' => sub {
	plan tests => scalar @{TEST_SEQUENCES()};
	for my $tcase (@{TEST_SEQUENCES()}) {
		my ($seq, $expected) = @{$tcase};
		is $expected, doubles_exist $seq;
	}
};

subtest 'Test the doubles_exist_vec() function' => sub {
	plan tests => scalar @{TEST_SEQUENCES()};
	for my $tcase (@{TEST_SEQUENCES()}) {
		my ($seq, $expected) = @{$tcase};
		is $expected, doubles_exist_vec $seq;
	}
};
