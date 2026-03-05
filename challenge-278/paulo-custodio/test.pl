#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "and2 Raku3 cousins5 Perl1 are4",                      "Perl and Raku are cousins");
test_line(1, "guest6 Python1 most4 the3 popular5 is2 language7",    "Python is the most popular guest language");
test_line(1, "Challenge3 The1 Weekly2",                             "The Weekly Challenge");

test_line(2, "challenge e",         "acehllnge");
test_line(2, "programming a",       "agoprrmming");
test_line(2, "champion b",          "champion");

done_testing;
