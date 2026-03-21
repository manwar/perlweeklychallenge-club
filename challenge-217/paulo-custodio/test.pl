#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote("([3, 1, 2], [5, 2, 4], [0, 1, 3])"),    "1");
test_line(1, quote("([2, 1], [4, 5])"),                     "4");
test_line(1, quote("([1, 0, 3], [0, 0, 0], [1, 2, 1])"),    "0");

test_line(2, "1 23",        "231");
test_line(2, "10 3 2",      "3210");
test_line(2, "31 2 4 10",   "431210");
test_line(2, "5 11 4 1 2",  "542111");
test_line(2, "1 10",        "110");

done_testing;
