#!/usr/bin/perl5
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.016;
use strict;
use warnings;

use Test::More;

plan tests => 1;

use constant T_COUNT_UNIQUE => [
	[
		["perl", "weekly", "challenge"],
		["raku", "weekly", "challenge"],
		2,
	],
	[
		["perl", "raku", "python"],
		["python", "java"],
		1,
	],
	[
		["guest", "contribution"],
		["fun", "weekly", "challenge"],
		0,
	],
];

sub count_common_hash_assume_unique($$) {
        my ($str1, $str2) = @_;

        my %set1 = map { ($_, 1) } @{$str1};
        scalar grep { defined $set1{$_} } @{$str2}
}

subtest hash_assume_unique => sub {
	plan tests => scalar @{T_COUNT_UNIQUE()};
	for my $tcase (@{T_COUNT_UNIQUE()}) {
        	my ($str1, $str2, $expected) = @{$tcase};
        	is count_common_hash_assume_unique($str1, $str2), $expected;
	}
};
