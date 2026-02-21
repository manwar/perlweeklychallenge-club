#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "ABC-D-E-F 3", "ABC-DEF");
test_line(1, "A-BC-D-E 2",  "A-BC-DE");
test_line(1, "-A-B-CD-E 4", "A-BCDE");

test_line(2, "55 22 44 33", "(4, 1, 3, 2)");
test_line(2, "10 10 10",    "(1, 1, 1)");
test_line(2, "5 1 1 4 3",   "(4, 1, 1, 3, 2)");

done_testing;
