#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abbaca",  'ca');
test_line(1, "azxxzy",  'ay');
test_line(1, "aaaaaaaa",'');
test_line(1, "aabccba", 'a');
test_line(1, "abcddcba",'');

test_line(2, "The cat has 3 kittens 7 toys 10 beds",        "true");
test_line(2, "Alice bought 5 apples 2 oranges 9 bananas",   "false");
test_line(2, "I ran 1 mile 2 days 3 weeks 4 months",        "true");
test_line(2, "Bob has 10 cars 10 bikes",                    "false");
test_line(2, "Zero is 0 one is 1 two is 2",                 "true");

done_testing;
