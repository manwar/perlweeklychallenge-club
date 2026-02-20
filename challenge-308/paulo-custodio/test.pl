#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote_list("perl weekly challenge", "raku weekly challenge"),  2);
test_line(1, quote_list("perl raku python", "python java"),                 1);
test_line(1, quote_list("guest contribution", "fun weekly challenge"),      0);

test_line(2, quote_list("1 2 3", "1"),      "(1, 0, 2, 1)");
test_line(2, quote_list("6 2 7 3", "4"),    "(4, 2, 0, 7, 4)");

done_testing;
