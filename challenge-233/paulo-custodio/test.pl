#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "aba aabb abcd bac aabc",  2);
test_line(1, "aabb ab ba",              3);
test_line(1, "aabb ab ba",              3);

test_line(2, "1 1 2 2 2 3",             "(3, 1, 1, 2, 2, 2)");
test_line(2, "2 3 1 3 2",               "(1, 3, 3, 2, 2)");
test_line(2, "-1 1 -6 4 5 -6 1 4 1",    "(5, -1, 4, 4, -6, -6, 1, 1, 1)");

done_testing;
