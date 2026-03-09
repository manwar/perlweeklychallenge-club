#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "10#11#12",                    "jkab");
test_line(1, "1326#",                       "acz");
test_line(1, "25#24#123",                   "yxabc");
test_line(1, "20#5",                        "te");
test_line(1, "1910#26#",                    "aijz");
test_line(1, "16#518#12# 23#5511#12#25#",   "perl weekly");

test_line(1, "-e jkab",         "10#11#12");
test_line(1, "-e acz",          "1326#");
test_line(1, "-e yxabc",        "25#24#123");
test_line(1, "-e te",           "20#5");
test_line(1, "-e aijz",         "1910#26#");
test_line(1, "-e perl weekly",  "16#518#12# 23#5511#12#25#");

test_line(2, quote("G()(al)"),          "Goal");
test_line(2, quote("G()()()()(al)"),    "Gooooal");
test_line(2, quote("(al)G(al)()()"),    "alGaloo");
test_line(2, quote("()G()G"),           "oGoG");
test_line(2, quote("(al)(al)G()()"),    "alalGoo");

done_testing;
