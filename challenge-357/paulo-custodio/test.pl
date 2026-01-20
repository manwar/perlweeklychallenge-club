#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, 3524,  3);
test_line(1, 6174,  0);
test_line(1, 9998,  5);
test_line(1, 1001,  4);
test_line(1, 9000,  4);
test_line(1, 1111,  -1);

test_line(2, 3, "1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1");
test_line(2, 4, "1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1");
test_line(2, 1, "1/1");
test_line(2, 6, "1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1, 6/1");
test_line(2, 5, "1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1");

done_testing;
