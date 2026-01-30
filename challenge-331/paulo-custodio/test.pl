#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN',   9);
The Weekly Challenge
IN
test_block(1, <<'IN',   5);
   Hello   World
IN
test_block(1, <<'IN',   3);
Let's begin the fun
IN

test_line(2, "fuck fcuk",   "true");
test_line(2, "love love",   "false");
test_line(2, "fodo food",   "true");
test_line(2, "feed feed",   "true");

done_testing;
