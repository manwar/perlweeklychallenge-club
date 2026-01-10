#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "123", "123");
test_line(1, "1234", "1,234");
test_line(1, "1000000", "1,000,000");
test_line(1, "1", "1");
test_line(1, "12345", "12,345");

test_line(2, "1 2 3 4 5",       "false");
test_line(2, "0 2 4 6 4 2 0",   "true");
test_line(2, "5 4 3 2 1",       "false");
test_line(2, "1 3 5 5 4 2",     "false");
test_line(2, "1 3 2",           "true");

done_testing;
