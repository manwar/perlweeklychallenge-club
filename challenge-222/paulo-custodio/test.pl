#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 1 4 2 1 3",     "3");
test_line(1, "5 1 2 3 4",       "0");
test_line(1, "1 2 3 4 5",       "5");

test_line(2, "2 7 4 1 8 1",     "1");
test_line(2, "1",       "1");
test_line(2, "1 1",     "0");

done_testing;
