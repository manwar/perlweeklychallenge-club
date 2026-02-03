#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 1 3 2 5", "4, 6");
test_line(1, "1 1 1",       "2, 3");
test_line(1, "2 2 1",       "3");

test_line(2, "4 1 2 3",     "[1,2], [2,3], [3,4]");
test_line(2, "1 3 7 11 15", "[1,3]");
test_line(2, "1 5 3 8",     "[1,3], [3,5]");

done_testing;
