#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN', 1);
-2 0 3 -5 2 -1
0 2
IN
test_block(1, <<'IN', -3);
1 -2 3 -4 5
1 3
IN
test_block(1, <<'IN', 2);
1 0 2 -1 3
3 4
IN
test_block(1, <<'IN', -2);
-5 4 -3 2 -1 0
0 3
IN
test_block(1, <<'IN', 1);
-1 0 2 -3 -2 1
0 2
IN

test_block(2, <<'IN', 2);
3 4
1 2
3 1
2 4
2 3
IN
test_block(2, <<'IN', 3);
2 5
3 4
2 3
1 5
2 5
IN
test_block(2, <<'IN', -1);
1 1
2 2
3 3
4 4
IN
test_block(2, <<'IN', 0);
0 0
0 1
1 0
0 2
2 0
IN
test_block(2, <<'IN', 0);
5 5
5 6
6 5
5 4
4 5
IN

done_testing;
