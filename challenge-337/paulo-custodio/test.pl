#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "6 5 4 8",     "2, 1, 0, 3");
test_line(1, "7 7 7 7",     "3, 3, 3, 3");
test_line(1, "5 4 3 2 1",   "4, 3, 2, 1, 0");
test_line(1, "-1 0 3 -2 1", "1, 2, 4, 0, 3");
test_line(1, "0 1 1 2 0",   "1, 3, 3, 4, 1");

test_block(2, <<'IN', 6);
2 3
0 1
1 1
IN
test_block(2, <<'IN', 0);
2 2
1 1
0 0
IN
test_block(2, <<'IN', 0);
3 3
0 0
1 2
2 1
IN
test_block(2, <<'IN', 2);
1 5
0 2
0 4
IN
test_block(2, <<'IN', 8);
4 2
1 0
3 1
2 0
0 1
IN

done_testing;
