#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "5 6 4 1",     4);
test_line(1, "4 5",         5);
test_line(1, "1 2 2 3",     1);

test_block(2, <<IN, <<OUT, 1);
According to a research at Cambridge University, it doesn't matter
in what order the letters in a word are, the only important thing
is that the first and last letter be at the right place. The rest
can be a total mess and you can still read it without problem.
This is because the human mind does not read every letter by
itself, but the word as a whole.
IN
Ainrcdocg to a reecarsh at Cbmgrdaie Uvtriensiy, it deosn't mtater
in what odrer the ltteers in a wrod are, the only ipamtnrot thnig
is that the frist and last letetr be at the rgiht pclae. The rset
can be a ttoal mess and you can stlil read it whuoitt peroblm.
This is bceusae the haumn mind deos not read erevy letetr by
istlef, but the wrod as a whloe.
OUT

done_testing;
