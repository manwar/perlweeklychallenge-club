#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 3 4",         21);
test_line(1, "2 7 1 19 18 3",   63);

test_line(2, 1,     "(0)");
test_line(2, 2,     "(-1, 1)");
test_line(2, 3,     "(-1, 0, 1)");
test_line(2, 4,     "(-2, -1, 1, 2)");

done_testing;
