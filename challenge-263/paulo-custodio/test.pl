#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2   1 5 3 2 4 2",     "(1, 2)");
test_line(1, "6   1 2 4 3 5",       "()");
test_line(1, "4   5 3 2 4 2 1",     "(4)");

test_line(2, "1 1   2 1   3 2   ,   2 2   1 3",         "[[1,4], [2,3], [3,2]]");
test_line(2, "1 2   2 3   1 3   3 2   ,    3 1   1 3",  "[[1,8], [2,3], [3,3]]");
test_line(2, "1 1   2 2   3 3   ,   2 3   2 4",         "[[1,1], [2,9], [3,3]]");

done_testing;
