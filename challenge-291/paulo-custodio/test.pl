#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "2 3 -1 8 4",  3);
test_line(1, "1 -1 4",      2);
test_line(1, "2 5",         -1);

test_block(2, "", <<OUT);
N= 2598960
n0= 1302540
n1= 1098240
n2= 123552
n3= 54912
n4= 10200
n5= 5108
n6= 3744
n7= 624
n8= 36
n9= 4
OUT

done_testing;
