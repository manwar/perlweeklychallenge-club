#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abc xyz tsu",     "1");
test_line(1, "rat cab dad",     "3");
test_line(1, "x y z",           "0");

test_line(2, "1,0,0,0,1  1",        "1");
test_line(2, "1,0,0,0,1  2",        "0");
test_line(2, "1,0,0,0,0,0,0,0,1  3","1");

done_testing;
