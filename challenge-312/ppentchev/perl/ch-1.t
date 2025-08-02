#!/usr/bin/perl5
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use strict;
use warnings;
use v5.16;    ## no critic qw(ValuesAndExpressions::ProhibitVersionStrings)

use List::Util qw(min reduce);
use Readonly;

use Test::More;

plan tests => 4;

Readonly my $LETTERS => 26;
Readonly my %OFFSET  => map { ( $_, ord() - ord 'a' ) } 'a' .. 'z';

sub distance($ $) {
	my ( $from, $to ) = @_;
	my $clockwise        = abs $OFFSET{$from} - $OFFSET{$to};
	my $counterclockwise = $LETTERS - $clockwise;
	return min( $clockwise, $counterclockwise );
}

sub _typing_time_single {
	my ( $acc,  $next ) = @_;
	my ( $prev, $res )  = @{$acc};
	return [ $next, $res + 1 + distance $prev, $next ];
}

sub typing_time($) {
	my ($str)   = @_;
	my @letters = split //ms, $str;
	if ( scalar @letters == 0 ) {
		return 0;
	}

	my $first = shift @letters;

	my $res = reduce { _typing_time_single $a, $b } [ $first, 1 + distance( 'a', $first ) ],
		@letters;
	return $res->[1];
}

Readonly my @TEST_WORDS => (
	[ q{},    0,  'nothing to do, nothing to say' ],
	[ 'aaa',  3,  'bang bang bang' ],
	[ 'abc',  5,  'they want us to check that' ],
	[ 'bza',  7,  'they want us to check that, too' ],
	[ 'zjpc', 34, 'they also want us to check that' ],
);

subtest correct_offsets => sub {
	plan tests => 4;

	is scalar keys %OFFSET, $LETTERS,     'as many as we want';
	is $OFFSET{'a'},        0,            'we have to start somewhere';
	is $OFFSET{'y'},        $LETTERS - 2, 'almost there';
	ok !defined $OFFSET{'C'}, 'we know what we want';
};

sub test_distance_clockwise($ $) {
	my ( $from, $to ) = @_;
	if ( $from le $to ) {
		return ord($to) - ord $from;
	}
	else {
		return $LETTERS - ( ord($from) - ord $to );
	}
}

sub test_distance_counterclockwise($ $) {
	my ( $from, $to ) = @_;
	return $from eq $to ? 0 : $LETTERS - test_distance_clockwise $from, $to;
}

subtest correct_distance => sub {
	plan tests => 14;

	is distance( 'a', 'a' ), test_distance_clockwise( 'a', 'a' ),
		'here I am, here I remain';
	is distance( 'a', 'a' ), test_distance_counterclockwise( 'a', 'a' ),
		'here I am, here I remain';

	is distance( 'a', 'b' ), test_distance_clockwise( 'a', 'b' ),
		'well hello, neighbor';
	isnt distance( 'a', 'b' ), test_distance_counterclockwise( 'a', 'b' ),
		'well hello, neighbor';
	is distance( 'b', 'a' ), test_distance_counterclockwise( 'b', 'a' ),
		'hello yourself, neighbor';
	isnt distance( 'b', 'a' ), test_distance_clockwise( 'b', 'a' ),
		'hello yourself, neighbor';

	is distance( 'a', 'm' ), test_distance_clockwise( 'a', 'm' ), 'so far away';
	isnt distance( 'a', 'm' ), test_distance_counterclockwise( 'a', 'm' ),
		'so far away';
	is distance( 'm', 'a' ), test_distance_counterclockwise( 'm', 'a' ),
		'might as well be on Mars';
	isnt distance( 'm', 'a' ), test_distance_clockwise( 'm', 'a' ),
		'might as well be on Mars';

	is distance( 'a', 'n' ), test_distance_clockwise( 'a', 'n' ),
		'to the left, to the right';
	is distance( 'a', 'n' ), test_distance_counterclockwise( 'a', 'n' ),
		'to the left, to the right';
	is distance( 'n', 'a' ), test_distance_clockwise( 'n', 'a' ),
		'step it up, step it up';
	is distance( 'n', 'a' ), test_distance_counterclockwise( 'n', 'a' ),
		'step it up, step it up';
};

sub test_typing_time_clockwise($) {
	my ($letter) = @_;
	return 1 + $OFFSET{$letter};
}

sub test_typing_time_counterclockwise($) {
	my ($letter) = @_;
	return 1 + $LETTERS - $OFFSET{$letter};
}

subtest correct_time_single_letter => sub {
	plan tests => 10;

	is typing_time 'a',   test_typing_time_clockwise('a'),        'bang';
	isnt typing_time 'a', test_typing_time_counterclockwise('a'), 'unbang';

	is typing_time 'b',   test_typing_time_clockwise('b'),        'whiz bang';
	isnt typing_time 'b', test_typing_time_counterclockwise('b'), 'unwhiz bang';

	is typing_time 'm',   test_typing_time_clockwise('m'),        'whoosh bang';
	isnt typing_time 'm', test_typing_time_counterclockwise('m'), 'unwhoosh bang';

	is typing_time 'n', test_typing_time_clockwise('n'), 'same either way';
	is typing_time 'n', test_typing_time_counterclockwise('n'),
		'same either way indeed';

	is typing_time 'o',   test_typing_time_counterclockwise('o'), 'counterwhoosh bang';
	isnt typing_time 'z', test_typing_time_clockwise('z'),        'counterwhiz unbang';
};

subtest correct_time_word => sub {
	plan tests => scalar @TEST_WORDS;

	for my $tcase (@TEST_WORDS) {
		my ( $word, $expected, $comment ) = @{$tcase};
		is typing_time $word, $expected, $comment;
	}
};
