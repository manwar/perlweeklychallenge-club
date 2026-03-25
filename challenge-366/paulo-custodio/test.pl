#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "apple     a ap app apple banana",                 4);
test_line(1, "bird      cat dog fish",                          0);
test_line(1, "hello     hello he hell heaven he",               4);
test_line(1, "coding    ".quote("")." code coding cod",         3);
test_line(1, "program   p pr pro prog progr progra program",    7);

test_line(2, "?2:34",   3);
test_line(2, "?4:?0",   12);
test_line(2, "??:??",   1440);
test_line(2, "?3:45",   3);
test_line(2, "2?:15",   4);

done_testing;
