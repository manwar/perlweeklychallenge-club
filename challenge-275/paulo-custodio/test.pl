#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "Perl Weekly Challenge , l a",     0);
test_line(1, "Perl and Raku , a",               1);
test_line(1, "Well done Team PWC , l o",        2);
test_line(1, "The joys of polyglottism , T",    2);

test_line(2, "a1c1e1",      "abcdef");
test_line(2, "a1b2c3d4",    "abbdcfdh");
test_line(2, "b2b",         "bdb");
test_line(2, "a16z",        "abgz");

done_testing;
