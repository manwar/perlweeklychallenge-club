#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "10001 1", 'true');
test_line(1, "10001 2", 'false');

test_block(2, <<'IN',   "12.75");
1 12 -5 -6 50 3
4
IN
test_block(2, <<'IN',   "5.00");
5
1
IN

done_testing;
