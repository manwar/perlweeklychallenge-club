#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "cat bt hat tree   atach",     "6");
test_line(1, "hello world challenge   welldonehopper",      "10");

test_line(2, "9 4 7 2 10",      "3");
test_line(2, "3 6 9 12",        "4");
test_line(2, "20 1 15 3 10 5 8",        "4");

done_testing;
