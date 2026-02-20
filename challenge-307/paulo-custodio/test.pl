#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "5 2 4 3 1",   "(0, 2, 3, 4)");
test_line(1, "1 2 1 1 3",   "(1, 3)");
test_line(1, "3 1 3 2 3",   "(0, 1, 3)");

test_line(2, "acca dog god perl repl",  3);
test_line(2, "abba baba aabb ab ab",    2);

done_testing;
