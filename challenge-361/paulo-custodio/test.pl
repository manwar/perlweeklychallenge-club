#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, 4,     "(3, 1)");
test_line(1, 12,    "(8, 3, 1)");
test_line(1, 20,    "(13, 5, 2)");
test_line(1, 96,    "(89, 5, 2)");
test_line(1, 100,   "(89, 8, 3)");

test_block(2, <<IN, 4);
0 0 0 0 1 0
0 0 0 0 1 0
0 0 0 0 1 0
0 0 0 0 1 0
0 0 0 0 0 0
0 0 0 0 1 0
IN
test_block(2, <<IN, -1);
0 1 0 0
0 0 1 0
0 0 0 1
1 0 0 0
IN
test_block(2, <<IN, 0);
0 0 0 0 0
1 0 0 0 0
1 0 0 0 0
1 0 0 0 0
1 0 0 0 0
IN
test_block(2, <<IN, 3);
0 1 0 1 0 1
1 0 1 1 0 0
0 0 0 1 1 0
0 0 0 0 0 0
0 1 0 1 0 0
1 0 1 1 0 0
IN
test_block(2, <<IN, -1);
0 1 1 0
1 0 1 0
0 0 0 0
0 0 0 0
IN
test_block(2, <<IN, -1);
0 0 1 1
1 0 0 0
1 1 0 1
1 1 0 0
IN

done_testing;
