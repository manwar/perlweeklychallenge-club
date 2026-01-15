#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1st Jan 2025",    "2025-01-01");
test_line(1, "22nd Feb 2025",   "2025-02-22");
test_line(1, "15th Apr 2025",   "2025-04-15");
test_line(1, "23rd Oct 2025",   "2025-10-23");
test_line(1, "31st Dec 2025",   "2025-12-31");

test_line(2, "1-23-45-6",   "123-456");
test_line(2, "1234",        "12-34");
test_line(2, "12 345-6789", "123-456-789");
test_line(2, "123 4567",    "123-45-67");
test_line(2, "123 456-78",  "123-456-78");

done_testing;
