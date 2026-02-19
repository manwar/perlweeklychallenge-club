#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote_list("1 2 3 4", "4 5 6 1", "4 2 1 3"),   "(1, 4)");
test_line(1, quote_list("1 0 2 3", "2 4 5"),                "(2)");
test_line(1, quote_list("1 2 3", "4 5", "6"),               "()");

test_line(2, "4 1 2 3",     "(2, 3, 4, 1)");
test_line(2, "3 1",         "(3, 1)");
test_line(2, "5 3 2 1 4",   "(2, 3, 4, 1, 5)");

done_testing;
