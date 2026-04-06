#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "10",      "(1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870)");

test_block(2, <<'IN', <<'OUT');
A = [ 1 2 ]
    [ 3 4 ]

B = [ 5 6 ]
    [ 7 8 ]
IN
[[  5,  6, 10, 12 ],
 [  7,  8, 14, 16 ],
 [ 15, 18, 20, 24 ],
 [ 21, 24, 28, 32 ]]
OUT

done_testing;
