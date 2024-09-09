#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use Test::More;

use lib 'tests/lib';

use PWCTest::Ch286 qw(test_order_game test_order_game_count test_order_game_default);

use constant PROG => 'perl/scripts/ch-2.pl';

plan tests => 2;

subtest order_game_default => sub {
	test_order_game_default PROG;
};

subtest order_game => sub {
    plan tests => test_order_game_count;
    for my $idx (1..test_order_game_count) {
        subtest "run $idx" => sub {
            test_order_game PROG, $idx - 1;
        };
    }
};
