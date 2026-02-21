#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "pERl",        "PerL");
test_line(1, "rakU",        "RAKu");
test_line(1, "PyThOn",      "pYtHoN");

test_line(2, "111122333 3",     "359");
test_line(2, "1222312 2",       "76");
test_line(2, "100012121001 4",  "162");

done_testing;
