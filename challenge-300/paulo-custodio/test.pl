#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, 2, 2);
test_line(1, 1, 1);
test_line(1, 10,700);

test_line(2, "5 4 0 3 1 6 2",   4);
test_line(2, "0 1 2",           1);

done_testing;
