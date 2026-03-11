#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "-3 1 2 -1 3 -2 4",    4);
test_line(1, "-1 -2 -3 1",          3);
test_line(1, "1 2",                 2);

test_line(2, "2   3 1 2 2 2 1 3",   4);
test_line(2, "1   1 2 3",           0);

done_testing;
