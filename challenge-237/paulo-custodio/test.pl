#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2024 4 3 2",      16);
test_line(1, "2025 10 2 4",     9);
test_line(1, "2026 8 5 3",      0);

test_line(2, "1 3 5 2 1 3 1",   4);
test_line(2, "1 2 3 4",         3);

done_testing;
