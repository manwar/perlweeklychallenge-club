#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abc xyz",     "false");
test_line(1, "scriptinglanguage perl",      "true");
test_line(1, "aabbcc abc",      "true");

test_line(2, "112358",      "true");
test_line(2, "12345",       "false");
test_line(2, "199100199",       "true");

done_testing;
