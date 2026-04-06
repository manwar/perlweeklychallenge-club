#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "dec_to_base2i     4",     "10300");
test_line(1, "base2i_to_dec 10300",     "4");

test_line(2, "2022-08-01 10:30 4",      "2022-08-01 14:30");
test_line(2, "2022-08-01 17:00 3.5",        "2022-08-02 11:30");

done_testing;
