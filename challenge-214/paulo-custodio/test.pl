#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 4 3 5",       "5 4 S B G");
test_line(1, "8 5 6 7 4",       "G 4 B S 5");
test_line(1, "3 5 4 2",         "B G S 4");
test_line(1, "2 5 2 1 7 5 1",   "4 S 4 6 G S 6");

test_line(2, "2 4 3 3 3 4 5 4 2",   "23");
test_line(2, "1 2 2 2 2 1",         "20");
test_line(2, "1",                   "1");
test_line(2, "2 2 2 1 1 2 2 2",     "40");

done_testing;
