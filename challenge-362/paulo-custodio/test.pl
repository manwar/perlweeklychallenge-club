#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abca",    "abbcccaaaa");
test_line(1, "xyz",     "xyyzzz");
test_line(1, "code",    "coodddeeee");
test_line(1, "hello",   "heelllllllooooo");
test_line(1, "a",       "a");

test_line(2, "6 7 8 9 10",      "(8, 9, 7, 6, 10)");
test_line(2, "-3 0 1000 99",    "(-3, 99, 1000, 0)");
test_line(2, "1 2 3 4 5",       "(5, 4, 1, 3, 2)");
test_line(2, "0 -1 -2 -3 -4",   "(-4, -1, -3, -2, 0)");
test_line(2, "100 101 102",     "(100, 101, 102)");

done_testing;
