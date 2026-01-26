#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "123 45 6",            123);
test_line(1, "abc de fghi",         4);
test_line(1, "0012 99 a1b2c",       99);
test_line(1, "x 10 xyz 007",        10);
test_line(1, "hello123 2026 perl",  2026);

test_line(2, "abc 1",       "bcd");
test_line(2, "xyz 2",       "zab");
test_line(2, "abc 27",      "bcd");
test_line(2, "hello 5",     "mjqqt");
test_line(2, "perl 26",     "perl");

done_testing;
