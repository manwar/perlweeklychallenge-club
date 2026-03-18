#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 3 4 5",       "(1, 3, 6, 10, 15)");
test_line(1, "1 1 1 1 1",       "(1, 2, 3, 4, 5)");
test_line(1, "0 -1 1 2",        "(0, -1, 0, 2)");

test_line(2, "15 99 1 34",      "(1, 15, 34, 99)");
test_line(2, "50 25 33 22",     "(22, 33, 50, 25)");

done_testing;
