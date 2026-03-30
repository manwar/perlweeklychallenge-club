#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote_list("1 2 3", "a b c"),  "(1, a, 2, b, 3, c)");

test_line(2, "", "ok");

done_testing;
