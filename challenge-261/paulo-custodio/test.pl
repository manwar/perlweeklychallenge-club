#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 3 45",        36);
test_line(1, "1 12 3",          9);
test_line(1, "1 2 3 4",         0);
test_line(1, "236 416 336 350", 1296);

test_line(2, "3   5 3 6 1 12",  24);
test_line(2, "1   1 2 4 3",     8);
test_line(2, "2   5 6 7",       2);

done_testing;
