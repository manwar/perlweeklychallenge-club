#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1011",    "1101");
test_line(1, "100",     "001");
test_line(1, "111000",  "110001");
test_line(1, "0101",    "1001");
test_line(1, "1111",    "1111");
test_line(1, "10",      "01");

for (["10:00 12:00", "11:00 13:00", "true" ],
     ["09:00 10:30", "10:30 12:00", "false"],
     ["14:00 15:30", "14:30 16:00", "true" ],
     ["08:00 09:00", "09:01 10:00", "false"],
     ["23:30 00:30", "00:00 01:00", "true" ]) {
    my($A, $B, $result) = @$_;
    test_line(2, "$A $B", $result);
    test_line(2, "$B $A", $result);
}

done_testing;
