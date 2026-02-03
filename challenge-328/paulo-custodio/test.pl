#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "a?z",     "abz");
test_line(1, "pe?k",    "peak");
test_line(1, "gra?te",  "grabte");

test_line(2, "WeEeekly",    "Weekly");
test_line(2, "abBAdD",      "");
test_line(2, "abc",         "abc");

done_testing;
