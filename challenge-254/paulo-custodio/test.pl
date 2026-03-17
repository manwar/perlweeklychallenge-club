#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, 27,    "true");
test_line(1, 0,     "true");
test_line(1, 6,     "false");

test_line(2, "Raku",    "Ruka");
test_line(2, "Perl",    "Perl");
test_line(2, "Julia",   "Jaliu");
test_line(2, "Uiua",    "Auiu");

done_testing;
