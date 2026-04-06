#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "11",      "eleventh");
test_line(1, "62",      "sixty-second");
test_line(1, "99",      "ninety-ninth");

test_line(2, "0 1 2 3 4 5 6 7 8 9 10",  "▁▁▂▃▃▄▅▅▆▇█");

done_testing;
