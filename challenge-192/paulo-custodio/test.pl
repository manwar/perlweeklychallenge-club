#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "5",       "2");
test_line(1, "4",       "3");
test_line(1, "6",       "1");

test_line(2, "3 3 3",       "0");
test_line(2, "1 0 5",       "4");
test_line(2, "0 2 0",       "-1");
test_line(2, "0 3 0",       "2");

done_testing;
