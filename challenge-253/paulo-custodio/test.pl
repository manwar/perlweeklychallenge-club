#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, ". one.two.three four.five six",       "(one, two, three, four, five, six)");
test_line(1, quote_list('$', '$perl$$', '$$raku$'), "(perl, raku)");

test_line(2, "[ [1, 1, 0, 0, 0], [1, 1, 1, 1, 0], [1, 0, 0, 0, 0], [1, 1, 0, 0, 0], [1, 1, 1, 1, 1] ]",
            "(2, 0, 3, 1, 4)");
test_line(2, "[ [1, 0, 0, 0], [1, 1, 1, 1], [1, 0, 0, 0], [1, 0, 0, 0] ]",
            "(0, 2, 3, 1)");

done_testing;
