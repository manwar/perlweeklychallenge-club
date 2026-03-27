#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "Perl 2 22 19 9",      "Raku");
test_line(1, "Raku 24 4 7 17",      "Perl");

test_line(2, "1 2 3 5 1 2 7 6 3    3",      "(1,2,3), (1,2,3), (5,6,7)");
test_line(2, "1 2 3    2",      "-1");
test_line(2, "1 2 4 3 5 3    3",        "(1,2,3), (3,4,5)");
test_line(2, "1 5 2 6 4 7    3",        "-1");

done_testing;
