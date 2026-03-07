#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "-1 -2 -3 -4 3 2 1",   1);
test_line(1, "1 2 0 -2 -1",         0);
test_line(1, "-1 -1 1 -1 2",        -1);

test_line(2, "abcdefghijklmnopqrstuvwxyz   10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10",
            "(3, 60)");
test_line(2, "bbbcccdddaaa   4 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10",
            "(2, 4)");

done_testing;
