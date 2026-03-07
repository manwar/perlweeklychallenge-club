#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 3 4 5",   "true");
test_line(1, "2 3 8 16",    "true");
test_line(1, "1 2 5 7 9",   "false");

test_line(2, "2 1 3 4 5",   "(2, 3, 4, 5, 1)");
test_line(2, "3 2 4",       "(3, 4, 2)");
test_line(2, "5 4 3 8",     "(5, 3, 4, 8)");

done_testing;
