#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "3 3 1",       1);
test_line(1, "3 2 4 2 4",   3);
test_line(1, "1",           1);
test_line(1, "4 3 1 1 1 4", 3);

test_line(2, "1 2 1 0", "true");
test_line(2, "0 3 0",   "false");

done_testing;
