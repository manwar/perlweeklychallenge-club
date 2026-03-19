#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2023",        "2");

test_line(2, quote("IV + V"),       "IX");
test_line(2, quote("M - I"),        "CMXCIX");
test_line(2, quote("X / II"),       "V");
test_line(2, quote("XI * VI"),      "LXVI");
test_line(2, quote("VII ** III"),   "CCCXLIII");
test_line(2, quote("V - V"),        "nulla");
test_line(2, quote("V / II"),       "non potest");
test_line(2, quote("MMM + M"),      "non potest");
test_line(2, quote("V - X"),        "non potest");

done_testing;
