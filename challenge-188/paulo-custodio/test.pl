#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "4 5 1 6   2",     "2");
test_line(1, "1 2 3 4   2",     "2");
test_line(1, "1 3 4 5   3",     "2");
test_line(1, "5 1 2 3   4",     "2");
test_line(1, "7 2 4 5   4",     "1");

test_line(2, "5 4",     "5");
test_line(2, "4 6",     "3");
test_line(2, "2 5",     "4");
test_line(2, "3 1",     "3");
test_line(2, "7 4",     "5");

done_testing;
