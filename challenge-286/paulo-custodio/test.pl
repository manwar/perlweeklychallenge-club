#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "3",       "Challenge");

test_line(2, "2 1 4 5 6 3 0 2",                 1);
test_line(2, "0 5 3 2",                         0);
test_line(2, "9 2 1 4 5 6 0 7 3 1 3 5 7 9 0 8", 2);

done_testing;
