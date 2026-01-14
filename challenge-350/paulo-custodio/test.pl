#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abcaefg",     5);
test_line(1, "xyzzabc",     3);
test_line(1, "aababc",      1);
test_line(1, "qwerty",      4);
test_line(1, "zzzaaa",      0);

test_line(2, "1 1000 1",                0);
test_line(2, "1500 2500 1",             3);
test_line(2, "1000000 1500000 5",       2);
test_line(2, "13427000 14100000 2",     11);
test_line(2, "1030 1130 1",             2);

done_testing;
