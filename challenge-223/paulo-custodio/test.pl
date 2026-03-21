#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "10",      "4");
test_line(1, "1",       "0");
test_line(1, "20",      "8");

test_line(2, "3 1 5 8",     "167");
test_line(2, "1 5",     "10");

done_testing;
