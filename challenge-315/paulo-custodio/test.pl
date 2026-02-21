#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN',   "(0, 1, 2)");
the weekly challenge
e
IN
test_block(1, <<'IN',   "(0, 2)");
perl raku python
p
IN
test_block(1, <<'IN',   "(0, 2, 3)");
abc def bbb bcd
b
IN

test_block(2, <<'IN',   "(language, too)");
Perl is a my favourite language but Python is my favourite too.
my
favourite
IN
test_block(2, <<'IN',   "(doll, princess)");
Barbie is a beautiful doll also also a beautiful princess.
a
beautiful
IN
test_block(2, <<'IN',   "(we, rock)");
we will we will rock you rock you.
we
will
IN

done_testing;
