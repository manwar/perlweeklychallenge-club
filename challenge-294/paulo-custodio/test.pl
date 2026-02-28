#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "10 4 20 1 3 2",       4);
test_line(1, "0 6 1 8 5 2 4 3 0 7", 9);
test_line(1, "10 30 20",            -1);

test_line(2, "1 2 3",   "(1, 3, 2)");
test_line(2, "2 1 3",   "(2, 3, 1)");
test_line(2, "3 1 2",   "(3, 2, 1)");

done_testing;
