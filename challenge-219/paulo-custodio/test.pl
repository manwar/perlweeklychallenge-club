#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "-2 -1 0 3 4",     "(0, 1, 4, 9, 16)");
test_line(1, "5 -4 -1 3 6",     "(1, 9, 16, 25, 36)");

test_line(2, "2 7 25   1 5 6 7 9 15",       "11");
test_line(2, "2 7 25   1 2 3 5 7 10 11 12 14 20 30 31",     "20");

done_testing;
