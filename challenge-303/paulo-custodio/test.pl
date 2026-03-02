#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2 1 3 0",     "(102, 120, 130, 132, 210, 230, 302, 310, 312, 320)");
test_line(1, "2 2 8 8 2",   "(222, 228, 282, 288, 822, 828, 882)");

test_line(2, "3 4 2",       6);
test_line(2, "2 2 3 3 3 4", 9);

done_testing;
