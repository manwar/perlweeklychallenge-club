#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "--x x++ x++",     1);
test_line(1, "x++ ++x x++",     3);
test_line(1, "x++ ++x --x x--", 0);

test_block(2, <<'IN',   2.65);
10
3 50
7 10
12 25
IN
test_block(2, <<'IN',   0.25);
2
1 0
4 25
5 50
IN
test_block(2, <<'IN',   0);
0
2 50
IN

done_testing;
