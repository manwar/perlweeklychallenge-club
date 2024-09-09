#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use List::Util qw(min max pairs);

use constant PWC_QUIET => ($ENV{PWC_QUIET} // '') eq 1;

my @TEST_SEQUENCES = (
	[2, 1, 4, 5, 6, 3, 0, 2],
	[0, 5, 3, 2],
	[9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8],
);

my $re_int = qr{^ (?P<value> -? (?: 0 | [1-9][0-9]* ) ) $}x;

sub diag($) {
	say STDERR $_[0] unless PWC_QUIET;
}

sub round_trivial(@)
{
	my (@ints) = @_;

	diag "- round_trivial() invoked for @ints";
	my @res;
	my $use_max = 0;
	for my $pair (pairs @ints) {
		my $winner = $use_max ? max @{$pair} : min @{$pair};
		push @res, $winner;
		$use_max = !$use_max;
	}
	@res
}

sub run_order_game(@)
{
	my (@ints) = @_;

	diag "run_order_game() invoked for ".scalar(@ints)." numbers: @ints";
	die 'run_order_game() expects at least one integer in the list' unless @ints;
	while (@ints > 1) {
		@ints = round_trivial @ints;
	}
	$ints[0]
}

sub parse_stdin()
{
	my $line = <STDIN>;
	if (!defined $line) {
		die "Could not read a line of space-separated numbers from the standard input\n";
	}
	chomp $line;

	my @res;
	for my $word (split /\s+/, $line) {
		if ($word !~ $re_int) {
			die "Not an integer: '$word'\n";
		}
		push @res, +$+{value};
	}
	@res
}

MAIN:
{
	if (($ENV{PWC_FROM_STDIN} // '') eq '1') {
		my @ints = parse_stdin;
		my $result = run_order_game @ints;
		say $result;
	} else {
		for my $seq (@TEST_SEQUENCES) {
			my $result = run_order_game @{$seq};
			say $result;
		}
	}
}
