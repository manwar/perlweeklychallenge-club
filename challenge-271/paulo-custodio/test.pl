#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "0 1 , 1 0",       1);
test_line(1, "0 0 0 , 1 0 1",   2);
test_line(1, "0 0 , 1 1 , 0 0", 2);

test_line(2, "0 1 2 3 4 5 6 7 8",   "(0, 1, 2, 4, 8, 3, 5, 6, 7)");
test_line(2, "1024 512 256 128 64", "(64, 128, 256, 512, 1024)");

done_testing;
