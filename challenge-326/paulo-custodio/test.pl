#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2025-02-02",  33);
test_line(1, "2025-04-10",  100);
test_line(1, "2025-09-07",  250);

test_line(2, "1 3 2 4", "3, 4, 4");
test_line(2, "1 1 2 2", "1, 2, 2");
test_line(2, "3 1 3 2", "1, 1, 1, 2, 2, 2");

done_testing;
