#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "20 3",        320);
test_line(1, "3 30 34 5 9", 9534330);

test_line(2, "4 14 2",  6);
test_line(2, "4 14 4",  4);

done_testing;
