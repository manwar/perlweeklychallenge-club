#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "lacelengh  3 2 0 5 4 8 6 7 1",        "challenge");
test_line(1, "rulepark  4 7 3 1 0 5 2 6",       "perlraku");

test_line(2, "1 5 0 3 5",       "3");
test_line(2, "0",       "0");
test_line(2, "2 1 4 0 3",       "4");

done_testing;
