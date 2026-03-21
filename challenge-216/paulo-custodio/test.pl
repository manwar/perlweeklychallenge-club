#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote_list("AB1 2CD", "abc", "abcd", "bcd"),       "abcd");
test_line(1, quote_list("007 JB", "job", "james", "bjorg"),     "job, bjorg");
test_line(1, quote_list("C7 RA2", "crack", "road", "rac"),      "crack, rac");

test_line(2, "peon perl raku python",               "2");
test_line(2, "goat love hate angry",                "3");
test_line(2, "accommodation come nation delta",     "4");
test_line(2, "accommodation come country delta",    "0");

done_testing;
