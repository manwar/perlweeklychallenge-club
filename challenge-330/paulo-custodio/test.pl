#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "cab12",   "c");
test_line(1, "xy99",    "");
test_line(1, "pa1erl",  "perl");

test_line(2, "PERL IS gREAT",           "Perl is Great");
test_line(2, "THE weekly challenge",    "The Weekly Challenge");
test_line(2, "YoU ARE A stAR",          "You Are a Star");

done_testing;
