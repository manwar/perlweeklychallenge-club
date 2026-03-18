#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, "", <<'OUT', quote_list("Mr. Wall", "Mrs. Wall", "Mr. Anwar", "Mrs. Anwar", "Mr. Conway", "Mr. Cross"));
Mr. Wall -> Mr. Anwar
Mrs. Wall -> Mrs. Anwar
Mr. Anwar -> Mr. Wall
Mrs. Anwar -> Mrs. Wall
Mr. Conway -> Mr. Cross
Mr. Cross -> Mr. Conway
OUT
test_block(1, "", <<'OUT', quote_list("Mr. Wall", "Mrs. Wall", "Mr. Anwar"));
Mr. Wall -> Mr. Anwar
Mrs. Wall -> Mr. Wall
Mr. Anwar -> Mrs. Wall
OUT

test_line(2, "abcdbca",             "bc");
test_line(2, "cdeabeabfcdfabgcd",   "ab");

done_testing;
