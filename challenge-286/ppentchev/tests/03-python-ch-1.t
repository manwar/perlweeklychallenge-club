#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use Test::More;

use lib 'tests/lib';

use PWCTest::Ch286 qw(find_python3 test_self_spammer);

my $py3;
BEGIN {
    $py3 = find_python3;
}

if (!defined $py3) {
    plan skip_all => 'no Python 3 interpreter found';
    exit 0;
}

plan tests => 1;

use constant PROG => 'python/scripts/ch-1.py';

subtest self_spammer => sub {
	test_self_spammer [$py3, '-B', '-u', '--', PROG], PROG;
};
