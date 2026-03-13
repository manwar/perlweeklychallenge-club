#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "6 12 25 1",       1286);
test_line(1, "10 7 31 5 2 2",   489);
test_line(1, "1 2 10",          112);

test_line(2, "[ [ 3,  7,  8], [ 9, 11, 13], [15, 16, 17] ]",                15);
test_line(2, "[ [ 1, 10,  4,  2], [ 9,  3,  8,  7], [15, 16, 17, 12] ]",    12);
test_line(2, "[ [7 ,8], [1 ,2] ]",                                          7);

done_testing;
