#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "5 2 1 6",         "(2, 1, 0, 3)");
test_line(1, "1 2 0 3",         "(1, 2, 0, 3)");
test_line(1, "0 1",             "(0, 1)");
test_line(1, "9 4 9 2",         "(2, 1, 2, 0)");

test_line(2, quote("[ [1, 1, 0], [0, 1, 0], [0, 0, 0] ]"),                                      0);
test_line(2, quote("[ [0, 1,-2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0] ]"),   1);
test_line(2, quote("[ [1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1,-1] ]"),                             1);
test_line(2, quote("[ [0, 1,-2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0] ]"),   0);
test_line(2, quote("[ [0, 1, 0], [1, 0, 0], [0, 0, 0] ]"),                                      0);
test_line(2, quote("[ [4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1,-1] ]"),                             0);

done_testing;
