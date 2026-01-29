#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN',   "true");
Perl Weekly Challenge
PWC
IN
test_block(1, <<'IN',   "true");
Bob Charlie Joe
BCJ
IN
test_block(1, <<'IN',   "false");
Morning Good
MM
IN

test_line(2, "desc dsec",       "true");
test_line(2, "fuck fcuk",       "true");
test_line(2, "poo eop",         "false");
test_line(2, "stripe sprite",   "true");

done_testing;
