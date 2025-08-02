#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use Test::More;

use lib 'tests/lib';

use PWCTest::Ch287 qw(find_raku test_strong_password test_strong_password_count test_strong_password_default);

use constant PROG => 'raku/scripts/ch-1.raku';

my $raku;
BEGIN {
    $raku = find_raku;
}

if (!defined $raku) {
    plan skip_all => 'no Raku interpreter found';
    exit 0;
}

plan tests => 2;

my $raku_prog = [$raku, '--', PROG];

subtest strong_password_default => sub {
	test_strong_password_default $raku_prog;
};

subtest strong_password => sub {
    plan tests => test_strong_password_count;
    for my $idx (1..test_strong_password_count) {
        subtest "run $idx" => sub {
            test_strong_password $raku_prog, $idx - 1;
        };
    }
};
