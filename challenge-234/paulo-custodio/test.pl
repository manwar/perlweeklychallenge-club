#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "java javascript julia",   "j a");
test_line(1, "bella label roller",      "e l l");
test_line(1, "cool lock cook",          "c o");

test_line(2, "4 4 2 4 3",           3);
test_line(2, "1 1 1 1 1",           0);
test_line(2, "4 7 1 10 7 4 1 1",    28);

done_testing;
