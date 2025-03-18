#!/usr/bin/perl5
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use strict;
use warnings;
use v5.16;    ## no critic qw(ValuesAndExpressions::ProhibitVersionStrings)

use List::Util qw(min reduce);
use Readonly;

use Test::More;

plan tests => 2;

sub re_escape_char($) {
	my ($chr) = @_;

	if ( $chr eq q{[} || $chr eq q{]} || $chr eq q{^} ) {
		return "\\$chr";
	}

	return "[$chr]";
}

sub broken_keys($ $) {
	my ( $name, $typed ) = @_;
	my $pattern =
		q{^} . join( q{}, map { re_escape_char($_) . q{+} } split //ms, $name ) . q{$};
	if ( $typed =~ qr{$pattern}xms ) {
		return 1;
	}
	else {
		return 0;
	}
}

Readonly my $TEST_ESCAPE_CHARS =>
	' ~!@#%^&*()_+`1234567890-=abcdefghijklmnopqrstuvwxyz[];m,./{}:"<>$' . q{'};    ## no critic qw(ValuesAndExpressions::RequireInterpolationOfMetachars)

Readonly my @TEST_BROKEN_KEYS => (
	[ 'perl',         'perrrl',          1 ],
	[ 'raku',         'rrakuuuu',        1 ],
	[ 'python',       'perl',            0 ],
	[ 'coffeescript', 'cofffeescccript', 1 ],
);

subtest check_re_escape => sub {
	plan tests => length $TEST_ESCAPE_CHARS;

	for my $chr ( split //ms, $TEST_ESCAPE_CHARS ) {
		subtest check_single_char => sub {
			plan tests => length $TEST_ESCAPE_CHARS;

			my $pattern = q{^} . re_escape_char($chr) . q{$};
			my $re      = qr{$pattern}xms;

			for my $other ( split //ms, $TEST_ESCAPE_CHARS ) {
				subtest check_chars => sub {
					plan tests => 5;
					if ( $chr eq $other ) {
						ok $other =~ $re,
							"'$other' matches '$pattern'";
					}
					else {
						ok $other !~ $re,
							"'$other' does not match '$pattern'";
					}

					ok q{} !~ $re, "'' does not match '$pattern'";

					ok "$chr$chr" !~ $re,
						"'$chr$chr' does not match '$pattern'";

					ok "$chr$other" !~ $re,
						"'$chr$other' does not match '$pattern'";

					ok "$other$other" !~ $re,
						"'$other$other' does not match '$pattern'";
				}
			}
		};
	}
};

subtest check_broken_keys => sub {
	plan tests => scalar @TEST_BROKEN_KEYS;

	for my $tcase (@TEST_BROKEN_KEYS) {
		my ( $name, $typed, $expected ) = @{$tcase};
		if ($expected) {
			ok broken_keys( $name, $typed ), "'$typed' could be '$name'";
		}
		else {
			ok !broken_keys( $name, $typed ), "'$typed' could not be '$name'";
		}
	}
};
