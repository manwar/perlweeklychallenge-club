#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1 0 1",           "(false, true, true)");
test_line(1, "1 1 0",           "(false, true, false)");
test_line(1, "1 1 1 1 0 1 0 0 0 0 1 0 1 0 0 1 0 0 0 1", "(false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true)");

test_block(2, <<'IN', "(raku, python, perl)");
perl python raku
h l a b y d e f g i r k m n o p q j s t u v w x c z
IN
test_block(2, <<'IN', "(challenge, the, weekly)");
the weekly challenge
c o r l d a b t e f g h i j k m n p q s w u v x y z
IN

done_testing;
