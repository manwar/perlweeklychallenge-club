#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2 8 10 11 15",    11);
test_line(1, "1 5 6 7 14",      6);
test_line(1, "8 20 25 28",      28);

test_line(2, "1 5 8 9",     1);
test_line(2, "9 4 1 7",     2);

done_testing;
