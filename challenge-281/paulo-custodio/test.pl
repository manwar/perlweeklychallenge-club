#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "a1",      "false");
test_line(1, "b1",      "true");
test_line(1, "g1",      "false");
test_line(1, "h1",      "true");
test_line(1, "a2",      "true");
test_line(1, "b2",      "false");
test_line(1, "g8",      "true");
test_line(1, "h8",      "false");
test_line(1, "d3",      "true");
test_line(1, "g5",      "false");
test_line(1, "e6",      "true");

test_line(2, "g2 a8",   4);
test_line(2, "g2 h2",   3);

done_testing;
