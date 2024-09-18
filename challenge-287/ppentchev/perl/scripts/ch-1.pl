#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use locale qw(:ctype);
use utf8;

use List::Util qw(reduce);

use constant DESIRED_LENGTH => 6;
use constant PWC_QUIET => ($ENV{PWC_QUIET} // '') eq 1;
use constant PWC_USE_LOCALE => ($ENV{PWC_USE_LOCALE} // '') eq 1;

my @TEST_STRINGS = (
	'a',
	'aB2',
	'PaaSW0rd',
	'PaaaSW0rd',
	'aaaaa',
);

sub diag($) {
	say STDERR $_[0] unless PWC_QUIET;
}

sub classify($)
{
	my ($char) = @_;

	if (PWC_USE_LOCALE) {
	    return 'lower' if $char =~ /[[:lower:]]/;
	    return 'upper' if $char =~ /[[:upper:]]/;
	    return 'digit' if $char =~ /[[:digit:]]/;
	    return 'unknown';
	}

    return 'lower' if $char =~ /[a-z]/;
    return 'upper' if $char =~ /[A-Z]/;
    return 'digit' if $char =~ /[0-9]/;
    return 'unknown';
}

sub examine_password($)
{
	my ($password) = @_;

	my %seen = map { $_ eq 'unknown' ? () : ($_, 1) } map { classify $_ } split //, $password;

	# This part can also be done with something like:
	# s/((.)\2*)/length($1)." "/eg
	# ...and then parsing the integers, but I don't think it's worth it.
	my $runs_state = reduce {
		my ($runs, $last, $count) = @{$a};
		if ($b eq $last) {
			[$runs, $last, $count + 1]
		} elsif ($count >= 3) {
			[[@{$runs}, $count], $b, 1]
		} else {
			[$runs, $b, 1]
		}
	} ([[], ' ', 0], split //, $password);
	my ($runs, $last, $count) = @{$runs_state};
	if ($count >= 3) {
		push @{$runs}, $count;
	}

	(length $password, 3 - scalar keys %seen, $runs)
}

sub diag_state($ $ $ $ $)
{
	my ($tag, $actions, $length, $missing, $runs) = @_;

	diag "state $tag: actions $actions, length $length, missing $missing, runs @{$runs}";
}

sub fix_runs($ $ $)
{
	my ($length, $missing, $runs) = @_;
	my $actions = 0;

	for my $run (@{$runs}) {
		my $delta = int($run / 3);
		$actions += $delta;
		if ($missing >= $delta) {
			$missing -= $delta;
		} else {
			$missing = 0;
		}
	}

	($actions, $length, $missing, [])
}

sub fix_length($ $ $)
{
	my ($length, $missing, $runs) = @_;

	if ($length >= DESIRED_LENGTH) {
		return (0, $length, $missing, $runs);
	}
	my $actions = DESIRED_LENGTH - $length;
	if ($missing >= $actions) {
		$missing -= $actions;
	} else {
		$missing = 0;
	}
	($actions, DESIRED_LENGTH, $missing, $runs)
}

sub fix_missing($ $ $)
{
	my ($length, $missing, $runs) = @_;
	($missing, $length, 0, $runs)
}

sub strong_password($)
{
	my ($password) = @_;
	my ($length_init, $missing_init, $runs_init) = examine_password($password);
	diag_state 'init', 0, $length_init, $missing_init, $runs_init;

	my ($actions_runs, $length_runs, $missing_runs, $runs_runs) = fix_runs($length_init, $missing_init, $runs_init);
	diag_state 'runs', $actions_runs, $length_runs, $missing_runs, $runs_runs;

	my ($actions_length, $length_length, $missing_length, $runs_length) = fix_length($length_runs, $missing_runs, $runs_runs);
	diag_state 'length', $actions_length, $length_length, $missing_length, $runs_length;

	my ($actions_missing, $length_missing, $missing_missing, $runs_missing) = fix_missing($length_length, $missing_length, $runs_length);
	diag_state 'missing', $actions_missing, $length_missing, $missing_missing, $runs_missing;

	my $actions =  $actions_runs + $actions_length + $actions_missing;
	diag_state 'final', $actions, $length_missing, $missing_missing, $runs_missing;
	$actions
}

sub parse_stdin()
{
	my $line = <STDIN>;
	if (!defined $line) {
		die "Could not read an expression on a line from the standard input\n";
	}
	chomp $line;
	$line
}

MAIN:
{
	if (($ENV{PWC_FROM_STDIN} // '') eq '1') {
		my $password = parse_stdin;
		say strong_password $password;
	} else {
		for my $password (@TEST_STRINGS) {
			say strong_password $password;
		}
	}
}
