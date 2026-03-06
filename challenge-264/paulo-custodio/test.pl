#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "PeRlwEeKLy",      "L");
test_line(1, "ChaLlenge",       "L");
test_line(1, "The",             "''");

test_line(2, "0 1 2 3 4 , 0 1 2 2 1",   "(0, 4, 1, 3, 2)");
test_line(2, "1 2 3 4 0 , 0 1 2 3 0",   "(0, 1, 2, 3, 4)");
test_line(2, "1 , 0",                   "(1)");

done_testing;
