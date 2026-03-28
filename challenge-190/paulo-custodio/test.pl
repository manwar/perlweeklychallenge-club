#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "Perl",    "1");
test_line(1, "TPF",     "1");
test_line(1, "PyThon",  "0");
test_line(1, "raku",    "1");

test_line(2, "11",      "(AA, K)");
test_line(2, "1115",    "(AAAE, AAO, AKE, KAE, KO)");
test_line(2, "127",     "(ABG, LG)");

done_testing;
