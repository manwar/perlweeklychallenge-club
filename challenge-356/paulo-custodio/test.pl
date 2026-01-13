#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, 4, 2);
test_line(1, 5, 3);
test_line(1, 6, 3);
test_line(1, 7, 4);
test_line(1, 8, 4);

test_line(2, "HAHAHH", "Team 2 defeated Team 6");
test_line(2, "HHHHHH", "Team 1 defeated Team 2");
test_line(2, "HHHAHA", "Team 4 defeated Team 2");
test_line(2, "HAHAAH", "Team 4 defeated Team 6");
test_line(2, "HAAHAA", "Team 5 defeated Team 1");

done_testing;
