#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "-nums 0 1 4 6 7 10 -diff 3",      2);
test_line(1, "-nums 4 5 6 7 8 9  -diff 2",      2);

test_line(2, "11 8 27 4",   "11 4 8 27");
test_line(2, "11 27 8 4",   "11 4 8 27");

done_testing;
