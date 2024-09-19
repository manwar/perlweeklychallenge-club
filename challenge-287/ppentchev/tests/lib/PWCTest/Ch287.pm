#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

package PWCTest::Ch287;

use v5.16;
use strict;
use warnings;

use Exporter qw(import);
use POSIX qw(dup2);
use Socket qw(AF_UNIX SOCK_STREAM);
use Test::Command qw();
use Test::More;

our @EXPORT_OK = qw(
	find_raku
	test_strong_password
	test_strong_password_count
	test_strong_password_default
	test_valid_number
	test_valid_number_count
	test_valid_number_default
);

# These are the examples from task 1.
my @TEST_PASSWORDS = (
	['a', 5],
	['aB2', 3],
	['PaaSW0rd', 0],
	['PaaaSW0rd', 1],
	['aaaaa', 2],
);

# These are the examples from task 2.
my @TEST_NUMBERS = (
	['1', 'true'],
	['a', 'false'],
	['.', 'false'],
	['1.2e4.2', 'false'],
	['-1.', 'true'],
	['+1E-8', 'true'],
	['.44', 'true'],
);

sub test_run_program($ $ $) {
	my ($cmd, $input, $expected) = @_;
	my $prog = "\`@{$cmd}\`";

	plan tests => 2;

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

	say $parent_in $input or die "Parent: could not write to the child: $!\n";
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

sub test_strong_password_default($) {
	my ($cmd) = @_;
	my $prog = "\`@{$cmd}\`";

	plan tests => 2;

	my $auto_cmd = Test::Command->new(cmd => ['env', 'PWC_FROM_STDIN=', @{$cmd}]);
	$auto_cmd->exit_is_num(0, "$prog exited with code 0");
	$auto_cmd->stdout_is_eq(
		"5\n3\n0\n1\n2\n",
		"$prog produced the correct output in autotest mode",
	);
}

sub test_strong_password_count() {
	scalar @TEST_PASSWORDS
}

sub test_strong_password($ $) {
	my ($cmd, $idx) = @_;
	my ($password, $expected) = @{$TEST_PASSWORDS[$idx]};

	test_run_program $cmd, $password, $expected;
}

sub test_valid_number_default($) {
	my ($cmd) = @_;
	my $prog = "\`@{$cmd}\`";

	plan tests => 2;

	my $auto_cmd = Test::Command->new(cmd => ['env', 'PWC_FROM_STDIN=', @{$cmd}]);
	$auto_cmd->exit_is_num(0, "$prog exited with code 0");
	$auto_cmd->stdout_is_eq(
		"true\nfalse\nfalse\nfalse\ntrue\ntrue\ntrue\n",
		"$prog produced the correct output in autotest mode",
	);
}

sub test_valid_number_count() {
	scalar @TEST_NUMBERS
}

sub test_valid_number($ $) {
	my ($cmd, $idx) = @_;
	my ($str, $expected) = @{$TEST_NUMBERS[$idx]};

	test_run_program $cmd, $str, $expected;
}

sub find_raku()
{
	my $prog = $ENV{RAKU} || 'raku';
	my $res = system { $prog } ($prog, '-e', 'use strict');
	(defined $res && $res == 0) ? $prog : undef
}

1;
