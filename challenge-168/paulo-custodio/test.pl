#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

# note: 12 overflows 32-bit ints
#test_line(1, "11",     "(2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977)");
test_line(1, "11",      "(2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721)");

test_line(2, "2",       "2");
test_line(2, "4",       "211");
test_line(2, "6",       "23");
test_line(2, "9",       "311");
test_line(2, "10",      "773");

done_testing;
