#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use Test::More;

use lib 'tests/lib';

use PWCTest::Ch287 qw(
	find_raku
	test_valid_number
	test_valid_number_count
	test_valid_number_default
);

my $raku;
BEGIN {
	$raku = find_raku;
}

if (!defined $raku) {
	plan skip_all => 'no Raku interpreter found';
	exit 0;
}

plan tests => 2;

use constant PROG => 'raku/scripts/ch-2.raku';

my $raku_prog = [$raku, '--', PROG];

subtest valid_number_default => sub {
	test_valid_number_default $raku_prog;
};

subtest valid_number => sub {
    plan tests => test_valid_number_count;
    for my $idx (1..test_valid_number_count) {
        subtest "run $idx" => sub {
            test_valid_number $raku_prog, $idx - 1;
        };
    }
};
