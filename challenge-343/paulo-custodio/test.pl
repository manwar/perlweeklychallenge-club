#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, " 4  2 -1  3 -2  ",    1);
test_line(1, "-5  5 -3  3 -1 1",    1);
test_line(1, " 7 -3  0  2 -8  ",    0);
test_line(1, "-2 -5 -1 -8     ",    1);
test_line(1, "-2  2 -4  4 -1 1",    1);

test_block(2, <<'IN', <<'OUT');
0 1 1
0 0 1
0 0 0
IN
Team 0
OUT

test_block(2, <<'IN', <<'OUT');
0 1 0 0
0 0 0 0
1 1 0 0
1 1 1 0
IN
Team 3
OUT

test_block(2, <<'IN', <<'OUT');
0 1 0 1
0 0 1 1
1 0 0 0
0 0 1 0
IN
Team 0
OUT

test_block(2, <<'IN', <<'OUT');
0 1 1
0 0 0
0 1 0
IN
Team 0
OUT

test_block(2, <<'IN', <<'OUT');
0 0 0 0 0
1 0 0 0 0
1 1 0 1 1
1 1 0 0 0
1 1 0 1 0
IN
Team 2
OUT

done_testing;
