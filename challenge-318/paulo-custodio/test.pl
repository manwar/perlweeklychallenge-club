#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abccccd",         "cccc");
test_line(1, "aaabcddddeefff",  "aaa, dddd, fff");
test_line(1, "abcdd",           "");

test_block(2, <<'IN', "true");
3 2 1 4
1 2 3 4
IN
test_block(2, <<'IN', "false");
1 3 4
4 1 3
IN
test_block(2, <<'IN', "true");
2
2
IN

done_testing;
