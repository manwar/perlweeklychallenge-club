#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2025-07-26",  "11111101001-111-11010");
test_line(1, "2000-02-02",  "11111010000-10-10");
test_line(1, "2024-12-31",  "11111101000-1100-11111");

test_line(2, "weekly",      "false");
test_line(2, "perl",        "true");
test_line(2, "challenge",   "false");

done_testing;
