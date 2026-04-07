#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "10",      "(113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933)");

test_line(2, "3",       "2");
test_line(2, "5",       "24");
test_line(2, "7",       "720");

done_testing;
