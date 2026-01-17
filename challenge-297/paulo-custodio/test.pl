#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 0",         2);
test_line(1, "0 1 0",       2);
test_line(1, "0 0 0 0 0",   0);
test_line(1, "0 1 0 0 1 0", 4);

test_line(2, "2 1 4 3",     2);
test_line(2, "2 4 1 3",     3);
test_line(2, "1 3 2 4 5",   0);

done_testing;
