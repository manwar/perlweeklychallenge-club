#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "10 1 111 24 1000",3);
test_line(1, "111 1 11111",     0);
test_line(1, "2 8 1024 256",    1);

test_line(2, "1  2 5 9 11 3",   17);
test_line(2, "2  2 5 9 11 3",   11);
test_line(2, "0  2 5 9 11 3",   2);

done_testing;
