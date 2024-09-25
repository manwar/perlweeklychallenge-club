#!/usr/bin/raku
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

my Int:D constant $DESIRED_LENGTH = 6;
my Bool:D constant $PWC_QUIET = (%*ENV{'PWC_QUIET'} // '') eq '1';
my Bool:D constant $PWC_USE_LOCALE = (%*ENV{'PWC_USE_LOCALE'} // '') eq '1';

my Str:D @TEST_STRINGS = 'a', 'aB2', 'PassW0rd', 'PaaaSW0rd', 'aaaaa';

sub diag(Str:D $msg)
{
	$msg.note unless $PWC_QUIET;
}

class Strength
{
	has Int:D $.actions is required is readonly;
	has Int:D $.length is required is readonly;
	has Int:D $.missing is required is readonly;
	has Int:D @.runs is required is readonly;

	method fix-runs() returns Strength:D
	{
		my $taken = (@.runs.map: (* / 3).Int).sum;
		my $missing = $.missing >= $taken ?? $.missing - $taken !! 0;
		Strength.new(:actions($.actions + $taken), :$.length, :$missing, :runs())
	}

	method fix-length() returns Strength:D
	{
		my $taken = $.length < $DESIRED_LENGTH ?? $DESIRED_LENGTH - $.length !! 0;
		my $missing = $.missing >= $taken ?? $.missing - $taken !! 0;
		Strength.new(:actions($.actions + $taken), :length($.length + $taken), :$missing, :@.runs)
	}

	method fix-missing() returns Strength:D
	{
		my $taken = $.missing > 0 ?? $.missing !! 0;
		Strength.new(:actions($.actions + $taken), :$.length, :missing(0), :@.runs)
	}
}

sub diag-strength(Str:D $tag, Strength:D $strength)
{
	diag "strength at $tag: "
		~ "actions " ~ $strength.actions
		~ ", length " ~ $strength.length
		~ ", missing " ~ $strength.missing
		~ ", runs " ~ $strength.runs.raku
		unless $PWC_QUIET;
}

class RunState
{
	has Int:D @.runs is required is readonly;
	has Str:D $.last is required is readonly;
	has Int:D $.count is required is readonly;

	method update(Str:D $char) returns RunState
	{
		if $char eq $.last {
			RunState.new(:@.runs, :$.last, :count($.count + 1))
		} elsif $.count >= 3 {
			RunState.new(:runs(|@.runs, $.count), :last($char), :count(1))
		} else {
			RunState.new(:@.runs, :last($char), :count(1))
		}
	}

	method update-finish() returns RunState
	{
		if $.count >= 3 {
			RunState.new(:runs(|@.runs, $.count), :last(' '), :count(0))
		} else {
			self
		}
	}
}

enum CharClass
(
	ChLower => 'lower',
	ChUpper => 'upper',
	ChDigit => 'digit',
);

sub classify(Str:D $char) returns CharClass
{
	if $PWC_USE_LOCALE {
        	given $char {
        		when / <lower> / { ChLower }
        		when / <upper> / { ChUpper }
        		when / <digit> / { ChDigit }
        		default { Nil }
        	}
	} else {
        	given $char {
        		when / <[a .. z]> / { ChLower }
        		when / <[A .. Z]> / { ChUpper }
        		when / <[0 .. 9]> / { ChDigit }
        		default { Nil }
        	}
	}
}

sub examine-password(Str:D $password) returns Strength:D
{
	my $length = $password.chars;
	my $run_init_state = RunState.new(:runs(), :last(' '), :count(0));
	my @chars = $password.split('', :skip-empty);
	my @runs = (
		reduce { $^state.update($^value) }, $run_init_state, |@chars
	).update-finish.runs;
	my $missing = 3 - @chars.map(&classify).grep(*.defined).Set.elems;
	Strength.new(:actions(0), :$length, :$missing, :@runs)
}

sub strong-password(Str:D $password) returns Int:D
{
	my $st_init = examine-password $password;
	diag-strength 'init', $st_init;

	my $st_runs = $st_init.fix-runs;
	diag-strength 'runs', $st_runs;

	my $st_length = $st_runs.fix-length;
	diag-strength 'length', $st_length;

	my $st_missing = $st_length.fix-missing;
	diag-strength 'missing', $st_missing;

	$st_missing.actions
}

{
	if (%*ENV{'PWC_FROM_STDIN'} // '') eq '1' {
		my $line = $*IN.get;
		say strong-password $line;
	} else {
        	for @TEST_STRINGS {
        		say strong-password $^password;
        	}
	}
}
