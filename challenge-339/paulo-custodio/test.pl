#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "5 9 3 4 6",   42);
test_line(1, "1 -2 3 -4",   10);
test_line(1, "-3 -1 -2 -4", 10);
test_line(1, "10 2 0 5 1",  50);
test_line(1, "7 8 9 10 10", 44);

test_line(2, "-5 1 5 -9 2",     1);
test_line(2, "10 10 10 -25",        30);
test_line(2, "3 -4 2 5 -6 1",   6);
test_line(2, "-1 -2 -3 -4",     0);
test_line(2, "-10 15 5",            10);

done_testing;
