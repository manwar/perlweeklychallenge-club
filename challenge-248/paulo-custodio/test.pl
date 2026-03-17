#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "loveleetcode e",  "(3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0)");
test_line(1, "aaab b",          "(3, 2, 1, 0)");

test_block(2, "", <<OUT, "[ [1,  2,  3,  4], [5,  6,  7,  8], [9, 10, 11, 12] ]");
[[ 14, 18, 22 ],
 [ 30, 34, 38 ]]
OUT
test_block(2, "", <<OUT, "[ [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1] ]");
[[ 2, 1, 0 ],
 [ 1, 2, 1 ],
 [ 0, 1, 2 ]]
OUT

done_testing;
