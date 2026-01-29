#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN',   "[1, 2], [3, 4]");
1 2 3 4
2 2
IN
test_block(1, <<'IN',   "[1, 2, 3]");
1 2 3
1 3
IN
test_block(1, <<'IN',   "[1], [2], [3], [4]");
1 2 3 4
4 1
IN

test_line(2, "1 3",         6);
test_line(2, "5 1 6",       28);
test_line(2, "3 4 5 6 7 8", 480);

done_testing;
