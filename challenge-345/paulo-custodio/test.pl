#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 3 2",           "(1)");
test_line(1, "2 4 6 5 3",       "(2)");
test_line(1, "1 2 3 2 4 1",     "(2, 4)");
test_line(1, "5 3 1",           "(0)");
test_line(1, "1 5 1 5 1 5 1",   "(1, 3, 5)");

test_line(2, " 5 -1 -1",            "(5, -1)");
test_line(2, " 3  7 -1 -1 -1",      "(7, 3, -1)");
test_line(2, " 2 -1  4 -1 -1",      "(2, 4, 2)");
test_line(2, "10 20 -1 30 -1 -1",   "(20, 30, 20)");
test_line(2, "-1 -1  5 -1",         "(-1, -1, 5)");

done_testing;
