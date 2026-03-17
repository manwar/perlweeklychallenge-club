#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "ab de ed bc",         1);
test_line(1, "aa ba cd ed",         0);
test_line(1, "uv qp st vu mn pq",   2);

test_line(2, "abcd 1234",           "a1b2c3d4");
test_line(2, "abc 12345",           "a1b2c345");
test_line(2, "abcde 123",           "a1b2c3de");

done_testing;
