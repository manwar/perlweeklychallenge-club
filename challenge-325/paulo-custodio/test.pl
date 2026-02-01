#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "0 1 1 0 1 1 1",   3);
test_line(1, "0 0 0 0",         0);
test_line(1, "1 0 1 0 1 1",     2);

test_line(2, "8 4 6 2 3",   "4, 2, 4, 2, 3");
test_line(2, "1 2 3 4 5",   "1, 2, 3, 4, 5");
test_line(2, "7 1 1 5",     "6, 0, 1, 5");

done_testing;
