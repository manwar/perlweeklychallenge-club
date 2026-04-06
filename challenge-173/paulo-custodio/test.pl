#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "5456",    "1");
test_line(1, "120",     "0");

test_line(2, "7",       "(2, 3, 7, 43, 1807, 3263443, 10650056950807)");

done_testing;
