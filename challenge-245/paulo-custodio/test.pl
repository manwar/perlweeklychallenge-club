#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "perl 2  c 1  python 3",       "c perl python");
test_line(1, "c++ 1  haskell 3  java 2",    "c++ java haskell");

test_line(2, "8 1 9",       981);
test_line(2, "8 6 7 1 0",   8760);
test_line(2, "1",           -1);

done_testing;
