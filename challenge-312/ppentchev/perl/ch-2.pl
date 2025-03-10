#!/usr/bin/perl5
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use strict;
use warnings;
use v5.16;    ## no critic qw(ValuesAndExpressions::ProhibitVersionStrings)

use Carp qw(croak);
use Readonly;

use Test::More;

plan tests => 2;

sub _parse($) {
	my ($str) = @_;
	my @chars = split //ms, $str;
	my %balls;

	while (@chars) {
		my ( $color, $box ) = ( shift @chars, shift @chars );
		my $cur_balls = ( $balls{$box} //= { 'R' => 0, 'G' => 0, 'B' => 0 } );
		if ( !defined( $cur_balls->{$color} ) ) {
			croak "Invalid color '$color' specified";
		}
		$cur_balls->{$color}++;
	}
	return \%balls;
}

sub count_full($) {
	my ($str) = @_;
	my $balls = _parse $str;
	return scalar grep { $_->{'R'} > 0 && $_->{'G'} > 0 && $_->{'B'} > 0 } values %{$balls};
}

Readonly my @TEST_DATA => (
	[ q{}, 'nothing to see here, move along', 0, {} ],

	[
		'R3', 'a single red ballo... err, ball',
		0, { '3' => { 'R' => 1, 'G' => 0, 'B' => 0 } },
	],

	[
		'G0B1R2R0B0',
		'the first example',
		1,
		{
			'0' => { 'R' => 1, 'G' => 1, 'B' => 1 },
			'1' => { 'R' => 0, 'G' => 0, 'B' => 1 },
			'2' => { 'R' => 1, 'G' => 0, 'B' => 0, },
		},
	],

	[
		'G1R3R6B3G6B1B6R1G3',
		'the second example',
		3,
		{
			'1' => { 'R' => 1, 'B' => 1, 'G' => 1 },
			'3' => { 'R' => 1, 'B' => 1, 'G' => 1 },
			'6' => { 'R' => 1, 'B' => 1, 'G' => 1 },
		},
	],

	[
		'B3B2G1B3',
		'the third example',
		0,
		{
			'1' => { 'R' => 0, 'G' => 1, 'B' => 0 },
			'2' => { 'R' => 0, 'G' => 0, 'B' => 1 },
			'3' => { 'R' => 0, 'G' => 0, 'B' => 2 },
		},
	],

);

subtest correct_parse => sub {
	plan tests => scalar @TEST_DATA;

	for my $tcase (@TEST_DATA) {
		my ( $str, $comment, undef, $balls ) = @{$tcase};

		is_deeply _parse($str), $balls, $comment;
	}
};

subtest correct_count_full => sub {
	plan tests => scalar @TEST_DATA;

	for my $tcase (@TEST_DATA) {
		my ( $str, $comment, $count_full, undef ) = @{$tcase};

		is_deeply count_full($str), $count_full, $comment;
	}
};
