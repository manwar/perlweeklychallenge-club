#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use strict;
use warnings;
use v5.16;    ## no critic qw(ValuesAndExpressions::ProhibitVersionStrings)

use Readonly;

use Test::More;

plan tests => 1;

sub upper_lower_tr($) {
	my ($str) = @_;

	$str =~ tr/A-Za-z/a-zA-Z/;
	return $str;
}

Readonly my @T_UPPER_LOWER => (
	[ 'pERl',   'PerL' ],
	[ 'rakU',   'RAKu' ],
	[ 'PyThOn', 'pYtHoN' ],
	[
		"This is a test.\nThis is only a test!",
		"tHIS IS A TEST.\ntHIS IS ONLY A TEST!",
	],
);

subtest upper_lower_tr => sub {
	plan tests => scalar @T_UPPER_LOWER;

	for my $tcase (@T_UPPER_LOWER) {
		my ( $str, $expected ) = @{$tcase};
		is upper_lower_tr $str, $expected, 'letter case switched correctly';
	}
};
