#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "B C , D B , C A",     "A");
test_line(1, "A Z",                 "Z");

test_line(2, 9,     2);
test_line(2, 15,    6);
test_line(2, 100,   292);

done_testing;
