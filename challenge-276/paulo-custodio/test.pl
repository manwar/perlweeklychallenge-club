#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "12 12 30 24 24",  2);
test_line(1, "72 48 24 5",      3);
test_line(1, "12 18 24",        0);

test_line(2, "1 2 2 4 1 5",     2);
test_line(2, "1 2 3 4 5",       5);

done_testing;
