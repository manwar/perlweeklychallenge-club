#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "a",           5);
test_line(1, "aB2",         3);
test_line(1, "PaaSW0rd",    0);
test_line(1, "Paaasw0rd",   1);
test_line(1, "aaaaa",       2);

test_line(2, "1",       "true");
test_line(2, "a",       "false");
test_line(2, ".",       "false");
test_line(2, "1.2e4.2", "false");
test_line(2, "-1.",     "true");
test_line(2, "+1E-8",   "true");
test_line(2, ".44",     "true");

done_testing;
