#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote_list("1 3", "3 1", "2 4", "6 8"),            2);
test_line(1, quote_list("1 2", "2 1", "1 1", "1 2", "2 2"),     3);

test_line(2, quote_list("1 1", "2 3", "3 2"),   "true");
test_line(2, quote_list("1 1", "2 2", "3 3"),   "false");
test_line(2, quote_list("1 1", "1 2", "2 3"),   "true");
test_line(2, quote_list("1 1", "1 2", "1 3"),   "false");
test_line(2, quote_list("1 1", "2 1", "3 1"),   "false");
test_line(2, quote_list("0 0", "2 3", "4 5"),   "true");

done_testing;
