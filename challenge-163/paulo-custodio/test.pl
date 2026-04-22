#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 3",       "3");
test_line(1, "2 3 4",       "2");

test_line(2, "1 2 3 4 5",       "42");
test_line(2, "1 3 5 7 9",       "70");

done_testing;
