#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "20",      "(4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299)");

test_line(2, "20",      "(72, 108, 200, 288, 392, 432, 500, 648, 675, 800, 864, 968, 972, 1125, 1152, 1323, 1352, 1372, 1568, 1800)");

done_testing;
