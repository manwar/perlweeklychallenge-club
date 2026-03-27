#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 3 4",     "-1");
test_line(1, "1 2 0 5",     "1");
test_line(1, "2 6 3 1",     "1");
test_line(1, "4 5 2 3",     "-1");

test_line(2, "2",       "2");
test_line(2, "15",      "24679");

done_testing;
