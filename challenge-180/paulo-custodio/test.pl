#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "Perl Weekly Challenge",   "0");
test_line(1, "Long Live Perl",          "1");

test_line(2, "1 4 2 3 5       3",       "(4, 5)");
test_line(2, "9 0 6 2 3 8 5   4",       "(9, 6, 8, 5)");

done_testing;
