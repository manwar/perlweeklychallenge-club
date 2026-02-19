#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abc",     5);
test_line(1, "bza",     7);
test_line(1, "zjpc",    34);

test_line(2, "G0B1R2R0B0",          1);
test_line(2, "G1R3R6B3G6B1B6R1G3",  3);
test_line(2, "B3B2G1B3",            0);

done_testing;
