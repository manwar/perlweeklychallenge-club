#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "5 2 9 1 7 6",     "2");
test_line(1, "4 2 3 1 5 0",     "4");
test_line(1, "4 2 3 1 5 0 5",       "4");

test_line(2, "/a/b/c/1/x.pl /a/b/c/d/e/2/x.pl /a/b/c/d/3/x.pl /a/b/c/4/x.pl /a/b/c/d/5/x.pl",       "/a/b/c");

done_testing;
