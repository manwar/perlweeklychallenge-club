#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 2 4 3 5 6", 1);
test_line(1, "0 2 4 8 3 5", 2);
test_line(1, "7 3 1 0 5 9", 2);

test_line(2, "ab#c ad#c",   "true");
test_line(2, "ab## a#b#",   "true");
test_line(2, "a#b c",       "false");

done_testing;
