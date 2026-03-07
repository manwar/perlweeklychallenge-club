#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 0 0 , 0 0 1 , 1 0 0",   1);
test_line(1, "1 0 0 , 0 1 0 , 0 0 1",   3);

test_line(2, "3 2   4 1",       9);
test_line(2, "2 1   2 3 3 3 5", 6);

done_testing;
