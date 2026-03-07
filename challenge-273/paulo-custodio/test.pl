#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "perl e",      25);
test_line(1, "java a",      50);
test_line(1, "python m",    0);
test_line(1, "ada a",       67);
test_line(1, "ballerina l", 22);
test_line(1, "analitik k",  13);

test_line(2, "aabb",        "true");
test_line(2, "abab",        "false");
test_line(2, "aaa",         "false");
test_line(2, "bbb",         "true");

done_testing;
