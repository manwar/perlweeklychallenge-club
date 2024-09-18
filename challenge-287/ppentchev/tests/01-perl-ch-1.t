#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use Test::More;

use lib 'tests/lib';

use PWCTest::Ch287 qw(test_strong_password test_strong_password_count test_strong_password_default);

use constant PROG => 'perl/scripts/ch-1.pl';

plan tests => 2;

subtest strong_password_default => sub {
	test_strong_password_default [PROG];
};

subtest strong_password => sub {
    plan tests => test_strong_password_count;
    for my $idx (1..test_strong_password_count) {
        subtest "run $idx" => sub {
            test_strong_password [PROG], $idx - 1;
        };
    }
};
