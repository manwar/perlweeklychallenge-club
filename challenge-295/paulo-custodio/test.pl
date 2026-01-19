#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "weeklychallenge  challenge weekly   ",    "true");
test_line(1, "perlrakuperl     raku perl          ",    "true");
test_line(1, "sonsanddaughters sons sand daughters",    "false");

test_line(2, "2 3 1 1 4",   2);
test_line(2, "2 3 0 4",     2);
test_line(2, "2 0 0 4",     -1);

done_testing;
