#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "3 1 2",           "6");
test_line(1, "4 1 3 2",         "24");
test_line(1, "-1 0 1 3 1",      "3");
test_line(1, "-8 2 -9 0 -4 3",  "216");

test_line(2, "0011 1010 1100",  "39");
test_line(2, "0",               "1");

done_testing;
