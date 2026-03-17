#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 2 1 1 3",             1);
test_line(1, "1 2 3",                   0);
test_line(1, "-2 0 1 -2 1 1 0 1 -2 9",  1);

test_line(2, "CAT",     3);
test_line(2, "GOOGLE",  88);
test_line(2, "SECRET",  255);

done_testing;
