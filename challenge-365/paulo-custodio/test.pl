#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abc   1",         6);
test_line(1, "az    2",         9);
test_line(1, "cat   1",         6);
test_line(1, "dog   2",         8);
test_line(1, "perl  3",         6);

test_line(2, "cat and dog",             3);
test_line(2, "a-b c! d,e",              2);
test_line(2, "hello-world! this is fun",4);
test_line(2, "wow! a-b-c nice.",        2);

done_testing;
