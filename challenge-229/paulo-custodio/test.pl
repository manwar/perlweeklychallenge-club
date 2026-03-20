#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abc bce cae",     "1");
test_line(1, "yxz cba mon",     "2");

test_line(2, "1 1 2 4 , 2 4 , 4",   "(2, 4)");
test_line(2, "4 1 , 2 4 , 1 2",     "(1, 2, 4)");

done_testing;
