#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use strict;
use warnings;
use v5.16;    ## no critic qw(ValuesAndExpressions::ProhibitVersionStrings)

use Carp       qw(croak);
use List::Util qw(sum);
use Readonly;

use Test::More;

plan tests => 2;

sub gds_trivial($ $) {
	my ( $str, $int ) = @_;

	while (1) {
		my $res = join q{}, map { sum split //ms } unpack "(A$int)*", $str;
		return $res if length $res <= $int;
		$str = $res;
	}
	croak 'unreachable';
}

sub gds_trivial_rec($ $);

sub gds_trivial_rec($ $) {
	my ( $str, $int ) = @_;
	my $res = join q{}, map { sum split //ms } unpack "(A$int)*", $str;
	return length $res <= $int ? $res : gds_trivial_rec $res, $int;
}

Readonly my @T_GROUP_DIGIT_SUM => (
	[ [ '111122333',    3 ], '359' ],
	[ [ '1222312',      2 ], '76' ],
	[ [ '100012121001', 4 ], '162' ],
);

subtest trivial => sub {
	plan tests => scalar @T_GROUP_DIGIT_SUM;

	for my $tcase (@T_GROUP_DIGIT_SUM) {
		my ( $input, $expected ) = @{$tcase};
		my ( $str,   $int )      = @{$input};
		is gds_trivial( $str, $int ), $expected, 'digits summed up correctly';
	}
};

subtest trivial_rec => sub {
	plan tests => scalar @T_GROUP_DIGIT_SUM;

	for my $tcase (@T_GROUP_DIGIT_SUM) {
		my ( $input, $expected ) = @{$tcase};
		my ( $str,   $int )      = @{$input};
		is gds_trivial_rec( $str, $int ), $expected, 'digits summed up correctly';
	}
};
