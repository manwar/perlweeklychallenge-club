#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "4 2 1 3",         "[1, 2], [2, 3], [3, 4]");
test_line(1, "10 100 20 30",    "[10, 20], [20, 30]");
test_line(1, "-5 -2 0 3",       "[-2, 0]");
test_line(1, "8 1 15 3",        "[1, 3]");
test_line(1, "12 5 9 1 15",     "[9, 12], [12, 15]");

test_block(2, <<'IN', <<'OUT');
matrix =    1, 2, 3,
            4, 5, 6,
            7, 8, 9,
k = 1
IN
9, 1, 2,
3, 4, 5,
6, 7, 8,
OUT

test_block(2, <<'IN', <<'OUT');
matrix =    10, 20,
            30, 40,
k = 1
IN
40, 10,
20, 30,
OUT

test_block(2, <<'IN', <<'OUT');
matrix =    1, 2,
            3, 4,
            5, 6,
k = 1
IN
6, 1,
2, 3,
4, 5,
OUT

test_block(2, <<'IN', <<'OUT');
matrix =    1, 2, 3,
            4, 5, 6,
k = 5
IN
2, 3, 4,
5, 6, 1,
OUT

test_block(2, <<'IN', <<'OUT');
matrix =    1, 2, 3, 4,
k = 1
IN
4, 1, 2, 3,
OUT

done_testing;
