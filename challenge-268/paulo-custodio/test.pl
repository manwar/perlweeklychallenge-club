#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "3 7 5 , 9 5 7",   2);
test_line(1, "1 2 1 , 5 4 4",   3);
test_line(1, "1 2 1 , 5 4 3",   -1);
test_line(1, "1 2 1 , 5 4",     -1);
test_line(1, "2 , 5",           3);

test_line(2, "2 5 3 4",         "(3, 2, 5, 4)");
test_line(2, "9 4 1 3 6 4 6 1", "(1, 1, 4, 3, 6, 4, 9, 6)");
test_line(2, "1 2 2 3",         "(2, 1, 3, 2)");

done_testing;
