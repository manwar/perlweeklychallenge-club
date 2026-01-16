#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote("1 2 3 4  ")."   12",    "1, 2, 4, 6");
test_line(1, quote("2 7 4    ")."  181",    "4, 5, 5");
test_line(1, quote("9 9 9    ")."    1",    "1, 0, 0, 0");
test_line(1, quote("1 0 0 0 0")." 9999",    "1, 9, 9, 9, 9");
test_line(1, quote("0        ")." 1000",    "1, 0, 0, 0");

test_line(2, quote("2 3  , 1  , 4")." ".quote("1  2  3  4   "), "true");
test_line(2, quote("1 3  , 2 4   ")." ".quote("1  2  3  4   "), "false");
test_line(2, quote("9 1  , 5 8, 2")." ".quote("5  8  2  9  1"), "true");
test_line(2, quote("1    , 3     ")." ".quote("1  2  3      "), "false");
test_line(2, quote("7 4 6        ")." ".quote("7  4  6      "), "true");

done_testing;
