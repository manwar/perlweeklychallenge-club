#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abbc",        "a2bc");
test_line(1, "aaabccc",     "3ab3c");
test_line(1, "abcc",        "ab2c");

test_line(1, "-d a2bc",     "abbc");
test_line(1, "-d 3ab3c",    "aaabccc");
test_line(1, "-d ab2c",     "abcc");

test_line(2, "1 2 2 2 1",   "true");
test_line(2, "2 2 2 4",     "false");
test_line(2, "2 2 2 2 4",   "false");
test_line(2, "3 4 1 4 3 1", "true");

done_testing;
