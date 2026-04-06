#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "",        "142857");

test_line(2, "100",     "(10, 12, 14, 16, 18, 21, 23, 25, 27, 30, 32, 34, 36, 41, 43, 45, 50, 52, 54, 61, 63, 70, 72, 81, 90)");

done_testing;
