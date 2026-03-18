#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "3 2 1 4",     "(3, 2)");
test_line(1, "3 1",         "-1");
test_line(1, "2 1 3",       "(2)");

test_line(2, "7868190130M7522 5303914400F9211 9273338290F4010", 2);
test_line(2, "1313579440F2036 2921522980M5644",                 0);

done_testing;
