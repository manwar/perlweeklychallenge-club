#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 3 4 5 6",     "(2, 4, 6, 1, 3, 5)");
test_line(1, "1 2",             "(2, 1)");
test_line(1, "1",               "(1)");

test_line(2, "1,2,6 5,6,7   1 7",       "(1, 2, 6, 7)");

done_testing;
