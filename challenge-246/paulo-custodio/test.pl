#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, "", <<'OUT', "1234");
11
14
16
17
37
49
OUT

test_line(2, "1 1 2 3 5",   "true");
test_line(2, "4 2 4 5 7",   "false");
test_line(2, "4 1 2 -3 8",  "true");

done_testing;
