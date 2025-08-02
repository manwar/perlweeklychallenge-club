#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use Test::More;

use lib 'tests/lib';

use PWCTest::Ch287 qw(
	test_valid_number
	test_valid_number_count
	test_valid_number_default
);

use constant PROG => 'rust/target/debug/ch-2';

if (! -f PROG) {
	plan skip_all => 'no ch-2 Rust debug binary found';
	exit 0;
}

plan tests => 2;

subtest valid_number_default => sub {
	test_valid_number_default [PROG];
};

subtest valid_number => sub {
    plan tests => test_valid_number_count;
    for my $idx (1..test_valid_number_count) {
        subtest "run $idx" => sub {
            test_valid_number [PROG], $idx - 1;
        };
    }
};
