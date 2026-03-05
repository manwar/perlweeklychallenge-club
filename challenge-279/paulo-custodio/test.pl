#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "REPL 3 2 1 4",        "PERL");
test_line(1, "AURK 2 4 1 3",        "RAKU");
test_line(1, "OHYNPT 5 4 2 6 1 3",  "PYTHON");

test_line(2, "perl",            "false");
test_line(2, "book",            "true");
test_line(2, "good morning",    "true");

done_testing;
