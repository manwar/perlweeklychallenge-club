#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "Mango is sweet , Mango is sour",      "(sour, sweet)");
test_line(1, "Mango Mango , Orange",                "(Orange)");
test_line(1, "Mango is Mango , Orange is Orange",   "()");

test_line(2, "1 0 0 2 , 0 3 4 0 , 0 5 6 0 , 7 0 0 1",   "true");
test_line(2, "1 2 3 , 4 5 6 , 7 8 9",                   "false");
test_line(2, "1 0 2 , 0 3 0 , 4 0 5",                   "true");

done_testing;
