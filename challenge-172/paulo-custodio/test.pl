#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "18 2",        "(5, 13)");
test_line(1, "19 3",        "(3, 5, 11)");

test_line(2, "0 0 1 2 63 61 27 13",     "(0.0, 0.5, 7.5, 44.0, 63.0)");

done_testing;
