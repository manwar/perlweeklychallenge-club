#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "a0b1c2",  "0a1b2c");
test_line(1, "abc12",   "a1b2c");
test_line(1, "0a2b1c3", "0a1b2c3");
test_line(1, "1a23",    "");
test_line(1, "ab123",   "1a2b3");

test_line(2, "0011",    4);
test_line(2, "0000",    3);
test_line(2, "1111",    3);
test_line(2, "0101",    3);
test_line(2, "011101",  5);

done_testing;
