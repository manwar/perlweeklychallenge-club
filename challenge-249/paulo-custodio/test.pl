#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "3 2 3 2 2 2", "((3, 3), (2, 2), (2, 2))");
test_line(1, "1 2 3 4",     "()");

test_line(2, "IDID",    "(0, 2, 1, 4, 3)");
test_line(2, "III",     "(0, 1, 2, 3)");
test_line(2, "DDI",     "(2, 1, 0, 3)");

done_testing;
