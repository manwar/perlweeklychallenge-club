#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "12344456",    "444");
test_line(1, "1233334",     "-1");
test_line(1, "10020003",    "000");
test_line(1, "1002003",     "-1");

test_line(2, "pPeERrLl",    3);
test_line(2, "rRr",         0);
test_line(2, "GoO",         1);

done_testing;
