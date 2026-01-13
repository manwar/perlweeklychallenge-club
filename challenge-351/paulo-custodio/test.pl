#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "8000 5000 6000 2000 3000 7000",   "5250");
test_line(1, "100000 80000 110000 90000",       "95000");
test_line(1, "2500 2500 2500 2500",             "0");
test_line(1, "2000",                            "0");
test_line(1, "1000 2000 3000 4000 5000 6000",   "3500");

test_line(2, "1 3 5 7 9",       "true");
test_line(2, "9 1 7 5 3",       "true");
test_line(2, "1 2 4 8 16",      "false");
test_line(2, "5 -1 3 1 -3",     "true");
test_line(2, "1.5 3 0 4.5 6",   "true");

done_testing;
