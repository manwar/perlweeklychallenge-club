#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "5 5 5 10 20",     "true");
test_line(1, "5 5 10 10 20",    "false");
test_line(1, "5 5 5 20",        "true");

test_line(2, "4 6 3 8 15 0 13 18 7 16 14 19 17 5 11 1 12 2 9 10",   3);
test_line(2, "0 1 13 7 6 8 10 11 2 14 16 4 12 9 17 5 3 18 15 19",   6);
test_line(2, "9 8 3 11 5 7 13 19 12 4 14 10 18 2 16 1 0 15 6 17",   1);

done_testing;
