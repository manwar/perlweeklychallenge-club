#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "8 1 2 2 3",   "(4, 0, 1, 1, 3)");
test_line(1, "6 5 4 8",     "(2, 1, 0, 3)");
test_line(1, "2 2 2",       "(0, 0, 0)");

test_line(2, "2 1 4",       141);

done_testing;
