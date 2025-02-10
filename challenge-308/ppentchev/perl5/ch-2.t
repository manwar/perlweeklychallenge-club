#!/usr/bin/perl5
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.016;
use strict;
use warnings;

use Test::More;

plan tests => 1;

use constant T_XOR => [
	[
		[1, 2, 3],
		1,
		[1, 0, 2, 1],
	],
	[
		[6, 2, 7, 3],
		4,
		[4, 2, 0, 7, 4],
	],
];

sub decode_xor($$) {
        my ($encoded, $current) = @_;
        my @res;

        for my $val (@{$encoded}) {
                push @res, $current;
                $current ^= $val;
        }
        push @res, $current;
        @res
}

subtest xor => sub {
	plan tests => scalar @{T_XOR()};
	for my $tcase (@{T_XOR()}) {
        	my ($encoded, $initial, $expected) = @{$tcase};
        	is decode_xor($encoded, $initial), @{$expected};
	}
};
