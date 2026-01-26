#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN', 4);
10 0001 111001 1 0
5 3
IN

test_block(1, <<'IN', 2);
10 1 0
1 1
IN

test_line(2, "-3 2 -3 4 2", 5);
test_line(2, "1 2",         1);
test_line(2, "1 -2 -3",     5);

done_testing;
