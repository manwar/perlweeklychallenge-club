#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "perl loves scala",        "true");
test_line(1, "love the programming",    "false");
test_line(1, "java awk kotlin node.js", "true");

test_line(2, "uvw bcudvew",     "true");
test_line(2, "aec abcde",       "false");
test_line(2, "sip javascript",  "true");

done_testing;
