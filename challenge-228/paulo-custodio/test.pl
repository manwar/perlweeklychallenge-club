#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2 1 3 2",     "4");
test_line(1, "1 1 1 1",     "0");
test_line(1, "2 1 3 4",     "10");

test_line(2, "3 4 2",       "5");
test_line(2, "1 2 3",       "3");

done_testing;
