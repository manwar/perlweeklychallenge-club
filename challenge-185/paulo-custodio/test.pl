#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "1ac2.34f0.b1c2",      "1a:c2:34:f0:b1:c2");
test_line(1, "abc1.20f1.345a",      "ab:c1:20:f1:34:5a");

test_line(2, "ab-cde-123 123.abc.420 3abc-0010.xy", "xx-xxe-123 xxx.xbc.420 xxxx-0010.xy");
test_line(2, "1234567.a a-1234-bc a.b.c.d.e.f",     "xxxx567.a x-xxx4-bc x.x.x.x.e.f");

done_testing;
