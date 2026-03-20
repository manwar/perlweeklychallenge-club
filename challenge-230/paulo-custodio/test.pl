#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 34 5 6",        "(1, 3, 4, 5, 6)");
test_line(1, "1 24 51 60",      "(1, 2, 4, 5, 1, 6, 0)");

test_line(2, "at  pay attention practice attend",   2);
test_line(2, "ja  janet julia java javascript",     3);

done_testing;
