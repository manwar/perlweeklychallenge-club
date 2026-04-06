#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "ab1234 cd5678 ef1342",        "(001234, 015678, 021342)");

test_line(2, quote_list("a 1 2 b 0", "3 c 4 d"),        "[[1,2,0], [3,4]] and [['a','b'], ['c','d']]");
test_line(2, quote_list("1 2", "p q r", "s 3" ,"4 5 t"),"[[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]");

done_testing;
