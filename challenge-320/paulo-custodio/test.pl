#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "-3 -2 -1 1 2 3",  3);
test_line(1, "-2 -1 0 0 1",     2);
test_line(1, "1 2 3 4",         4);

test_line(2, "1 23 4 5",    18);
test_line(2, "1 2 3 4 5",   0);
test_line(2, "1 2 34",      27);

done_testing;
