#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "0 2 9 4 6",       "true");
test_line(1, "5 1 3 2",         "false");
test_line(1, "2 2 3",           "true");
test_line(1, "1 2 3 1 2 3",     "false");

test_line(2, "1 0 2 3 0 4 5 0", "(1, 0, 0, 2, 3, 0, 0, 4)");
test_line(2, "1 2 3",           "(1, 2, 3)");
test_line(2, "0 3 0 4 5",       "(0, 0, 3, 0, 0)");

done_testing;
