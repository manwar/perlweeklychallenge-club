#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "0 1 2",               0);
test_line(1, "4 3 2 1",             2);
test_line(1, "1 2 3 4 5 6 7 8 9 0", -1);

test_line(2, "perl 2 000 python r4ku",  6);
test_line(2, "001 1 000 0001",          1);

done_testing;
