#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote("(()())"),           6);
test_line(1, quote(")()())"),           4);
test_line(1, quote("((()))()(((()"),    8);
test_line(1, quote("))))((()("),        2);
test_line(1, quote("()(()"),            2);

test_line(2, "123  6",  "(1*2*3, 1+2+3)");
test_line(2, "105  5",  "(1*0+5, 10-5)");
test_line(2, "232  8",  "(2*3+2, 2+3*2)");
test_line(2, "1234 10", "(1*2*3+4, 1+2+3+4)");
test_line(2, "1001 2",  "(1+0*0+1, 1+0+0+1, 1+0-0+1, 1-0*0+1, 1-0+0+1, 1-0-0+1)");

done_testing;
