#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote_list("(1, 2, 3)", "(2, 4, 6)"),          "([1, 3], [4, 6])");
test_line(1, quote_list("(1, 2, 3, 3)", "(1, 1, 2, 2)"),    "([3])");

test_line(2, quote("([1, 1, 0], [1, 0, 1], [0, 0, 0])"),        "([1, 0, 0], [0, 1, 0], [1, 1, 1])");
test_line(2, quote("([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])"),
                                        "([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])");

done_testing;
