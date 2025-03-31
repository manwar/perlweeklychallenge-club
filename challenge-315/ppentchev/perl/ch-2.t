#!/usr/bin/perl5
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use strict;
use warnings;
use v5.16;    ## no critic qw(ValuesAndExpressions::ProhibitVersionStrings)

use Readonly;

use Test::More;

plan tests => 1;

sub find_third($ $ $) {
	my ( $sentence, $w_first, $w_second ) = @_;
	my @words = grep { length } split /\W+/xms, $sentence;
	if ( scalar @words <= 2 ) {
		return ();
	}

	my @res;
	my ( $c_first, $c_second ) = ( shift @words, shift @words );
	while (@words) {
		my $c_next = shift @words;
		if ( $c_first eq $w_first && $c_second eq $w_second ) {
			push @res, $c_next;
		}
		( $c_first, $c_second ) = ( $c_second, $c_next );
	}
	return @res;
}

Readonly my @TEST_FIND_THIRD => (
	[
		'Perl is a my favourite language but Python is my favourite too.',
		'my', 'favourite', [ 'language', 'too' ],
	],
	[
		'Barbie is a beautiful doll also also a beautiful princess.',
		'a', 'beautiful', [ 'doll', 'princess' ],
	],
	[ 'we will we will rock you rock you.', 'we', 'will', [ 'we', 'rock' ] ],
);

subtest check_find_third => sub {
	plan tests => scalar @TEST_FIND_THIRD;

	for my $tcase (@TEST_FIND_THIRD) {
		my ( $sentence, $w_first, $w_second, $expected ) = @{$tcase};
		is_deeply [ find_third( $sentence, $w_first, $w_second ) ], $expected,
			"words after '$w_first' and '$w_second' in '$sentence' are @{$expected}";
	}
};
