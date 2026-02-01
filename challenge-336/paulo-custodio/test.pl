#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 1 2 2 2 2",             "true");
test_line(1, "1 1 1 2 2 2 3 3",         "false");
test_line(1, "5 5 5 5 5 5 7 7 7 7 7 7", "true");
test_line(1, "1 2 3 4",                 "false");
test_line(1, "8 8 9 9 10 10 11 11",     "true");

test_line(2, "5 2 C D +",               30);
test_line(2, "5 -2 4 C D 9 + +",        27);
test_line(2, "7 D D C + 3",             45);
test_line(2, "-5 -10 + D C +",          -55);
test_line(2, "3 6 + D C 8 + D -2 C +",  128);

done_testing;
