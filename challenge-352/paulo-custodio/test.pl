#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "cat cats dog dogcat dogcat rat ratcatdogcat",
             "cat, dog, dogcat, rat");
test_line(1, "hello hell world wor ellow elloworld",
             "hell, world, wor, ellow");
test_line(1, "a aa aaa aaaa",
             "a, aa, aaa");
test_line(1, "flower flow flight fl fli ig ght",
             "flow, fl, fli, ig, ght");
test_line(1, "car carpet carpenter pet enter pen pent",
             "car, pet, enter, pen, pent");

test_line(2, "0 1 1 0 0 1 0 1 1 1",
             "true, false, false, false, false, true, true, false, false, false");
test_line(2, "1 0 1 0 1 0",
             "false, false, true, true, false, false");
test_line(2, "0 0 1 0 1",
             "true, true, false, false, true");
test_line(2, "1 1 1 1 1",
             "false, false, false, true, false");
test_line(2, "1 0 1 1 0 1 0 0 1 1",
             "false, false, true, false, false, true, true, true, false, false");

done_testing;
