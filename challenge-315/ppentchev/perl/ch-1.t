#!/usr/bin/perl5
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use strict;
use warnings;
use v5.16;    ## no critic qw(ValuesAndExpressions::ProhibitVersionStrings)

use Readonly;

use Test::More;

plan tests => 1;

sub find_words($ $) {
	my ( $list, $char ) = @_;

	return grep { index( $list->[$_], $char ) >= 0 } ( 0 .. $#{$list} );
}

Readonly my @TEST_FIND_WORDS => (
	[ [ 'the', 'weekly', 'challenge' ], 'e', [ 0, 1, 2 ] ],
	[ [ 'perl', 'raku', 'python' ],     'p', [ 0, 2 ] ],
	[ [ 'abc', 'def', 'bbb', 'bcd' ],   'b', [ 0, 2, 3 ] ],
);

subtest check_find_words => sub {
	plan tests => scalar @TEST_FIND_WORDS;

	for my $tcase (@TEST_FIND_WORDS) {
		my ( $list, $char, $expected ) = @{$tcase};
		is_deeply [ find_words( $list, $char ) ], $expected,
			"character $char in @{$list} at @{$expected}";
	}
};
