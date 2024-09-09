#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use Test::More;

use lib 'tests/lib';

use PWCTest::Ch286 qw(test_self_spammer);

use constant PROG => 'perl/scripts/ch-1.pl';

plan tests => 1;

subtest self_spammer => sub {
	test_self_spammer PROG;
};
