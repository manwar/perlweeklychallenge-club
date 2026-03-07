#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 3 3 3 3 4 2",     3);
test_line(1, "1 1",                 1);
test_line(1, "1 2 3",               1);

test_line(2, quote_list("aBc 11c", "accbbb", "abc", "abbc"),    "accbbb");
test_line(2, quote_list("Da2 abc", "abcm", "baacd", "abaadc"),  "baacd");
test_line(2, quote_list("JB 007", "jj", "bb", "bjb"),           "bjb");

done_testing;
