#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "acbddbca",    "d");
test_line(1, "abccd",       "c");
test_line(1, "abcdabbb",    "a");

test_line(2, quote("p|*e*rl|w**e|*ekly|"),          2);
test_line(2, quote("perl"),                         0);
test_line(2, quote("th|ewe|e**|k|l***ych|alleng|e"),5);

done_testing;
