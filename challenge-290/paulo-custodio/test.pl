#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "6 2 3 3",     "true");
test_line(1, "3 1 4 13",    "false");
test_line(1, "2 1 4 2",     "true");

test_line(2, "17893729974",         "true");
test_line(2, "4137 8947 1175 5904", "true");
test_line(2, "4137 8974 1175 5904", "false");

done_testing;
