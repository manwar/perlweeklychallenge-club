#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "12-01 20-01 15-01 18-01",     "4");
test_line(1, "02-03 12-03 13-03 14-03",     "0");
test_line(1, "02-03 12-03 11-03 15-03",     "2");
test_line(1, "30-03 05-04 28-03 02-04",     "4");

test_line(2, "1 2 3 2",     "(3, 2, 2)");
test_line(2, "1 3 2",       "()");
test_line(2, "1 1 2 3",     "()");
test_line(2, "2 4 3",       "(4, 3, 2)");

done_testing;
