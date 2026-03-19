#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 3 2 3 1",   2);
test_line(1, "2 4 3 5 1",   3);

test_line(2, "2 5 9",           10);
test_line(2, "7 7 7 7 7 7 7",   49);

done_testing;
