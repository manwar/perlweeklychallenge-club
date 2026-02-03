#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "bella label roller",  "e l l");
test_line(1, "cool lock cook",      "c o");
test_line(1, "hello world pole",    "l o");
test_line(1, "abc def ghi",         "");
test_line(1, "aab aac aaa",         "a a");

test_block(2, <<'IN', "A");
0 0
2 0
1 1
2 1
2 2
IN
test_block(2, <<'IN', "B");
0 0
1 1
0 1
0 2
1 0
2 0
IN
test_block(2, <<'IN', "Draw");
0 0
1 1
2 0
1 0
1 2
2 1
0 1
0 2
2 2
IN
test_block(2, <<'IN', "Pending");
0 0
1 1
IN
test_block(2, <<'IN', "B");
1 1
0 0
2 2
0 1
1 0
0 2
IN

done_testing;
