#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN',   4);
1 0 1 0 0
1 0 1 1 1
1 1 1 1 1
1 0 0 1 0
IN
test_block(1, <<'IN',   1);
0 1
1 0
IN
test_block(1, <<'IN',   0);
0
IN

test_line(2, quote_list("3 4", "2 3", "1 2"),   "(-1, 0, 1)");
test_line(2, quote_list("1 4", "2 3", "3 4"),   "(-1, 2, -1)");
test_line(2, quote_list("1 2"),                 "(-1)");
test_line(2, quote_list("1 4", "2 2", "3 4"),   "(-1, 1, -1)");

done_testing;
