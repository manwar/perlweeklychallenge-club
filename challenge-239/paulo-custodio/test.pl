#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "ab c , a bc",     "true");
test_line(1, "ab c , ac b",     "false");
test_line(1, "ab cd e , abcde", "true");

test_line(2, "ab   ad bd aaab baa badab",       2);
test_line(2, "abc   a b c ab ac bc abc",        7);
test_line(2, "cad   cc acd b ba bac bad ac d",  4);

done_testing;
