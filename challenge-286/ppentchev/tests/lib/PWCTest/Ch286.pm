#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

package PWCTest::Ch286;

use v5.16;
use strict;
use warnings;

use Exporter qw(import);
use POSIX qw(dup2);
use Socket qw(AF_UNIX SOCK_STREAM);
use Test::Command qw();
use Test::More;

our @EXPORT_OK = qw(
	find_python3
	test_order_game
	test_order_game_count
	test_order_game_default
	test_self_spammer
);

use constant NUM_TESTS => 100;

# The last three of these are the example sequences from task 2.
# The rest are simple tests to make sure the order of numbers within the pairs does not matter.
my @TEST_ORDER_SEQUENCES = (
	[[1, 2], 1],
	[[2, 1], 1],
	[[1, 2, 3, 4], 1],
	[[2, 1, 4, 3], 1],
	[[4, 3, 2, 1], 2],
	[[3, 4, 1, 2], 2],

	[[2, 1, 4, 5, 6, 3, 0, 2], 1],
	[[0, 5, 3, 2], 0],
	[[9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8], 2],
);

my $re_single_line = qr{^ (?<word> [^\n\s]+ ) \n $}x;

sub test_self_spammer($;$) {
	my ($cmd, $source) = @_;
	$source //= $cmd->[0];
	my $prog = "\`@{$cmd}\`";

	# So... to test this, we basically have to implement it, right?
	my @words = do {
		open my $inf, '<', $source or die "Could not open $source: $!\n";
		my $contents = do {
			local $/;
			<$inf>
		};
		close $inf or die "Could not read the whole of $source: $!\n";
		split /\s+/, $contents;
	};

	plan tests => 4 * NUM_TESTS;

	for my $run (1..NUM_TESTS) {
		diag "About to run $prog";
		my $cmd = Test::Command->new(cmd => $cmd);
		$cmd->exit_is_num(0, "$prog exited with code 0");
		$cmd->stdout_isnt_eq('', "$prog output something");

		SKIP:
		{
			my $output = $cmd->stdout_value;
			if ($output !~ $re_single_line) {
				fail "$prog output a single line containing a single word";
				skip "no program output to look for in $source", 1;
				return;
			}
			pass "$prog output a single line containing a single word";

			my $word = $+{word};
			diag "Looking for '$word' in $source";
			ok grep { $_ eq $word } @words, "'$word' is present in $source";
		}
	}
}

sub test_order_game_default($) {
	my ($cmd) = @_;
	my $prog = "\`@{$cmd}\`";

	plan tests => 2;

	my $auto_cmd = Test::Command->new(cmd => ['env', 'PWC_FROM_STDIN=', @{$cmd}]);
	$auto_cmd->exit_is_num(0, "$prog exited with code 0");
	$auto_cmd->stdout_is_eq("1\n0\n2\n", "$prog produced the correct output in autotest mode");
}

sub test_order_game_count() {
	scalar @TEST_ORDER_SEQUENCES
}

sub test_order_game($ $) {
	my ($cmd, $idx) = @_;
	my $prog = "\`@{$cmd}\`";

	plan tests => 2;

	my ($seq, $expected) = @{$TEST_ORDER_SEQUENCES[$idx]};
	my $joined = join ' ', @{$seq};

	# OK, so Test::Command cannot handle this one; let's do it ourselves
	socketpair(my $parent_in, my $child_in, AF_UNIX, SOCK_STREAM, 0) or
		die "Could not create the stdin socket pair: $!\n";
	socketpair(my $child_out, my $parent_out, AF_UNIX, SOCK_STREAM, 0) or
		die "Could not create the stdout socket pair: $!\n";
	my $pid = fork();
	if (!defined $pid) {
		die "Could not fork for $prog: $!\n";
	} elsif ($pid == 0) {
		close $parent_in or die "Child: could not close parent_in: $!\n";
		close $parent_out or die "Child: could not close parent_out: $!\n";
		dup2(fileno $child_in, 0) or die "Child: could not dup2 child_in onto stdin: $!\n";
		dup2(fileno $child_out, 1) or die "Child: could not dup2 child_out onto stdout: $!\n";

		$ENV{PWC_FROM_STDIN} = '1';
		exec { $cmd->[0] } @{$cmd};
		die "Child: could not execute $prog: $!\n";
	}

	close $child_in or die "Parent: could not close child_in: $!\n";
	close $child_out or die "Parent: could not close child_out: $!\n";

	say $parent_in $joined or die "Parent: could not write to the child: $!\n";
	close $parent_in or die "Parent: could not close parent_in: $!\n";

	my $line = <$parent_out>;
	close $parent_out or die "Parent: could not close parent_out: $!\n";
	is $line, "$expected\n", "$prog produced the correct output";
	my $awaited_pid = waitpid $pid, 0;
	if (!defined $awaited_pid) {
		die "Parent: could not wait for child pid $pid: $!\n";
	} elsif ($awaited_pid != $pid) {
		die "Parent: waited for pid $pid, yet got status $? for pid $awaited_pid\n";
	}
	is $?, 0, "$prog exited with code 0";
}

sub find_python3()
{
	my $prog = $ENV{PYTHON3} || 'python3';
	my $res = system { $prog } ($prog, '-c', 'pass');
	(defined $res && $res == 0) ? $prog : undef
}

1;
