#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "15456  5",    "1546");
test_line(1, "7332   3",    "732");
test_line(1, "2231   2",    "231");
test_line(1, "543251 5",    "54321");
test_line(1, "1921   1",    "921");

test_line(2, "100061  0",   3);
test_line(2, "971088  0",   3);
test_line(2, "63640   1",   6);
test_line(2, "988841  1",   2);
test_line(2, "211529  0",   2);

done_testing;
