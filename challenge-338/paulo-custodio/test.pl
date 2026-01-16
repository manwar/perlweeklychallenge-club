#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN',   16);
4  4 4 4
10 0 0 0
2  2 2 9
IN
test_block(1, <<'IN',   10);
1 5
7 3
3 5
IN
test_block(1, <<'IN',   6);
1 2 3
3 2 1
IN
test_block(1, <<'IN',   17);
2 8 7
7 1 3
1 9 5
IN
test_block(1, <<'IN',   100);
10 20  30
5  5   5
0  100 0
25 25  25
IN

test_block(2, <<'IN',   6);
4 5 7
9 1 3 4
IN
test_block(2, <<'IN',   6);
2 3 5 4
3 2 5 5 8 7
IN
test_block(2, <<'IN',   9);
2 1 11 3
2 5 10 2
IN
test_block(2, <<'IN',   2);
1 2 3
3 2 1
IN
test_block(2, <<'IN',   5);
1 0 2 3
5 0
IN

done_testing;
