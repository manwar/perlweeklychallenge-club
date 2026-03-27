#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2",       "(00, 01, 10, 11)");
test_line(1, "3",       "(000, 001, 010, 011, 100, 101, 110, 111)");

test_line(2, "adc wzy abc",     "abc");
test_line(2, "aaa bob ccc ddd", "bob");
test_line(2, "aaa ccc ddd",     ".");

done_testing;
