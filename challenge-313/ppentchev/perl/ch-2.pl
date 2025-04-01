#!/usr/bin/perl5
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use strict;
use warnings;
use v5.16;    ## no critic qw(ValuesAndExpressions::ProhibitVersionStrings)

use Carp    qw(croak);
use English qw(--no_match_vars);
use Data::Dumper;
use List::Util qw(min reduce);
use Readonly;

use Test::More;

plan tests => 3;

Readonly my $RE_STARTING_NON_LETTERS => qr{
    ^
        (?P<weird> [^A-Za-z]+ )
        (?P<rest> .* )
    $
}xms;

Readonly my $RE_LETTERS => qr{
    ^
        (?P<letters> [A-Za-z]+ )
        (?P<others> [^A-Za-z]* )
        (?P<rest> .* )
    $
}xms;

sub parse_letters($) {
	my ($str) = @_;

	my @res;

	if ( $str =~ $RE_STARTING_NON_LETTERS ) {
		push @res, [ q{}, $LAST_PAREN_MATCH{weird} ];
		$str = $LAST_PAREN_MATCH{rest};
	}

	# Check for a non-letter at the very start
	while ( $str ne q{} ) {
		if ( $str !~ $RE_LETTERS ) {
			croak 'Could not parse ' . Dumper($str);
		}
		push @res, [ $LAST_PAREN_MATCH{letters}, $LAST_PAREN_MATCH{others} ];
		$str = $LAST_PAREN_MATCH{rest};
	}

	return map { [ [ split //ms, $_->[0] ], $_->[1] ] } @res;
}

sub reverse_parsed($) {
	my ($parsed) = @_;
	my @letters = reverse map { @{ $_->[0] } } @{$parsed};

	my $res = q{};
	for my $group ( @{$parsed} ) {
		my $count = scalar @{ $group->[0] };
		$res .= join q{}, @letters[ 0 .. ( $count - 1 ) ];
		@letters = @letters[ $count .. $#letters ];

		$res .= $group->[1];
	}
	return $res;
}

sub reverse_letters($) {
	my ($str) = @_;
	my @parsed = parse_letters $str;
	return reverse_parsed \@parsed;
}

Readonly my @TEST_REVERSE_LETTERS => (
	[
		'p-er?l', 'l-re?p',
		[ [ [q{p}], q{-} ], [ [ q{e}, q{r} ], q{?} ], [ [q{l}], q{} ] ],
	],
	[
		'wee-k!L-y',
		'yLk-e!e-w',
		[
			[ [ q{w}, q{e}, q{e} ], q{-} ],
			[ [q{k}],               q{!} ],
			[ [q{L}],               q{-} ],
			[ [q{y}],               q{} ],
		],
	],
	[
		'_c-!h_all-en!g_e',
		'_e-!g_nel-la!h_c',
		[
			[ [],                   q{_} ],
			[ [q{c}],               q{-!} ],
			[ [q{h}],               q{_} ],
			[ [ q{a}, q{l}, q{l} ], q{-} ],
			[ [ q{e}, q{n} ],       q{!} ],
			[ [q{g}],               q{_} ],
			[ [q{e}],               q{} ],
		],
	],
);

subtest test_parse => sub {
	plan tests => scalar @TEST_REVERSE_LETTERS;
	for my $tcase (@TEST_REVERSE_LETTERS) {
		my ( $str, undef, $exp_parsed ) = @{$tcase};
		my @parsed = parse_letters $str;
		is_deeply \@parsed, $exp_parsed,
			'parse the string into letters and other characters';
	}
};

subtest test_reverse_parsed => sub {
	plan tests => scalar @TEST_REVERSE_LETTERS;
	for my $tcase (@TEST_REVERSE_LETTERS) {
		my ( undef, $expected, $exp_parsed ) = @{$tcase};
		my $res = reverse_parsed $exp_parsed;
		is $res, $expected, 'build a string back out of the parsed groups';
	}
};

subtest test_full => sub {
	plan tests => scalar @TEST_REVERSE_LETTERS;
	for my $tcase (@TEST_REVERSE_LETTERS) {
		my ( $str, $expected, undef ) = @{$tcase};
		my $res = reverse_letters $str;
		is $res, $expected, 'go all the way';
	}
};
