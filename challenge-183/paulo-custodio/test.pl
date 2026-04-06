#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1,2 3,4 5,6 1,2",     "([1,2], [3,4], [5,6])");
test_line(1, "9,1 3,7 2,5 2,5",     "([9,1], [3,7], [2,5])");

test_line(2, "2019-02-10 2022-11-01",       "3 years 264 days");
test_line(2, "2020-09-15 2022-03-29",       "1 year 195 days");
test_line(2, "2019-12-31 2020-01-01",       "1 day");
test_line(2, "2019-12-01 2019-12-31",       "30 days");
test_line(2, "2019-12-31 2020-12-31",       "1 year");
test_line(2, "2019-12-31 2021-12-31",       "2 years");
test_line(2, "2020-09-15 2021-09-16",       "1 year 1 day");
test_line(2, "2019-09-15 2021-09-16",       "2 years 1 day");

done_testing;
