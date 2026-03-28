#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "emug b",      "e");
test_line(1, "dcef a",      "c");
test_line(1, "jar o",       "r");
test_line(1, "dcaf a",      "c");
test_line(1, "tgal v",      "v");

test_line(2, "1 3 3 2",     "(3, 3)");
test_line(2, "1 2 1 3",     "(1, 2, 1)");
test_line(2, "1 3 2 1 2",       "(2, 1, 2)");
test_line(2, "1 1 2 3 2",       "(1, 1)");
test_line(2, "2 1 2 1 1",       "(1, 2, 1, 1)");

done_testing;
