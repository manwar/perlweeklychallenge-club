#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use Test::More;

use lib 'tests/lib';

use PWCTest::Ch286 qw(
	find_python3
	test_order_game
	test_order_game_count
	test_order_game_default
);

my $py3;
BEGIN {
	$py3 = find_python3;
}

if (!defined $py3) {
	plan skip_all => 'no Python 3 interpreter found';
	exit 0;
}

plan tests => 2;

use constant PROG => 'python/scripts/ch-2.py';

my $py3_prog = [$py3, '-B', '-u', '--', PROG];

subtest order_game_default => sub {
	test_order_game_default $py3_prog;
};

subtest order_game => sub {
    plan tests => test_order_game_count;
    for my $idx (1..test_order_game_count) {
        subtest "run $idx" => sub {
            test_order_game $py3_prog, $idx - 1;
        };
    }
};
