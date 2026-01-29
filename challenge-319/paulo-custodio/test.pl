#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "unicode xml raku perl",   2);
test_line(1, "the weekly challenge",    2);
test_line(1, "perl python postgres",    0);

test_block(2, <<'IN',   3);
1 2 3 4
3 4 5 6
IN
test_block(2, <<'IN',   2);
1 2 3
2 4
IN
test_block(2, <<'IN',   -1);
1 2 3 4
5 6 7 8
IN


done_testing;
