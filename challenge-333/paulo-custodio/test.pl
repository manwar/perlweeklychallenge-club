#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2 1  2 3  2 5",   "true");
test_line(1, "1 4  3 4  10 4",  "true");
test_line(1, "0 0  1 1  2 3",   "false");
test_line(1, "1 1  1 1  1 1",   "true");
test_line(1, "1000000 1000000  2000000 2000000  3000000 3000000",   "true");

test_line(2, "1 0 2 3 0 4 5 0", "1, 0, 0, 2, 3, 0, 0, 4");
test_line(2, "1 2 3",           "1, 2, 3");
test_line(2, "1 2 3 0",         "1, 2, 3, 0");
test_line(2, "0 0 1 2",         "0, 0, 0, 0");
test_line(2, "1 2 0 3 4",       "1, 2, 0, 0, 3");

done_testing;
