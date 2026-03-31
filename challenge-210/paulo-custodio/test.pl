#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2 3 1",       "6");
test_line(1, "1 1 2 2 2 3",     "11");

test_line(2, "2 3 -1",      "(2, 3)");
test_line(2, "3 2 -4",      "(-4)");
test_line(2, "1 -1",        "()");

done_testing;
