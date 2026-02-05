#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, 38,            "Persistence  = 2\nDigital Root = 2");
test_line(1, 7,             "Persistence  = 0\nDigital Root = 7");
test_line(1, 999,           "Persistence  = 2\nDigital Root = 9");
test_line(1, 1999999999,    "Persistence  = 3\nDigital Root = 1");
test_line(1, 101010,        "Persistence  = 1\nDigital Root = 3");

test_line(2, "aabbccdd",    "");
test_line(2, "abccba",      "");
test_line(2, "abcdef",      "abcdef");
test_line(2, "aabbaeaccdd", "aea");
test_line(2, "mississippi", "m");

done_testing;
