#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "textbook",            2);
test_line(1, "aaaaa",               5);
test_line(1, "hoorayyy",            3);
test_line(1, "x",                   1);
test_line(1, "aabcccddeeffffghijjk",4);

test_line(2, "ULD",             'false');
test_line(2, "ULDR",            'true');
test_line(2, "UUURRRDDD",       'false');
test_line(2, "UURRRDDLLL",      'true');
test_line(2, "RRUULLDDRRUU",    'true');

done_testing;
