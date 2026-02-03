#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "the1weekly2challenge2",       "1, 2");
test_line(1, "go21od1lu5c7k",               "21, 1, 5, 7");
test_line(1, "4p3e2r1l",                    "4, 3, 2, 1");

test_line(2, "YaaAho",  "aaA");
test_line(2, "cC",      "cC");
test_line(2, "A",       "");

done_testing;
