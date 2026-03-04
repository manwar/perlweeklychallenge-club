#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2 2 3 4",     2);
test_line(1, "1 2 2 3 3 3", 3);
test_line(1, "1 1 1 3",     -1);

test_line(2, "2 3 9 3 1 4 6 7 2 8 5 , 2 1 4 3 5 6", "(2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)");
test_line(2, "3 3 4 6 2 4 2 1 3 , 1 3 2",           "(1, 3, 3, 3, 2, 2, 4, 4, 6)");
test_line(2, "3 0 5 0 2 1 4 1 1 , 1 0 3 2",         "(1, 1, 1, 0, 0, 3, 2, 4, 5)");

done_testing;
