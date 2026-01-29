#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2 5 3 6 4",   77);
test_line(1, "1 3",         4);

test_line(2, "3 8 5 2 9 2", 1);
test_line(2, "3 2 5",       0);

done_testing;
