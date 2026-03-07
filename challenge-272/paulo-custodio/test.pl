#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1.1.1.1",     "1[.]1[.]1[.]1");
test_line(1, "255.101.1.0", "255[.]101[.]1[.]0");

test_line(2, "hello",       13);
test_line(2, "perl",        30);
test_line(2, "raku",        37);

done_testing;
