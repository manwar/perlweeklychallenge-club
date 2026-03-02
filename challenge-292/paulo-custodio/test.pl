#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2 4 1 0", 1);
test_line(1, "1 2 3 4", -1);

test_line(2, "WRRBBW RB",       -1);
test_line(2, "WWRRBBWW WRBRW",  2);
test_line(2, "G GGGGG",         2);

done_testing;
