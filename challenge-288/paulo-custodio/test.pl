#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, 123,   121);
test_line(1, 2,     1);
test_line(1, 1400,  1441);
test_line(1, 1001,  999);

test_line(2, "xxxxo xoooo xoooo xxxoo", 11);
test_line(2, "xxxxx xoooo xxxxo xoooo", 11);
test_line(2, "xxxoo oooxx oxxoo oooxx", 7);

done_testing;
