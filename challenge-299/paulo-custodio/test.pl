#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN', <<'OUT');
cat bat rat
the cattle was rattle by the battery
IN
the cat was rat by the bat
OUT

test_block(1, <<'IN', <<'OUT');
a b c
aab aac and cac bab
IN
a a a c b
OUT

test_block(1, <<'IN', <<'OUT');
man bike
the manager was hit by a biker
IN
the man was hit by a bike
OUT

test_block(2, <<'IN', "true");
A B D E
C B C A
B A A D
D B B C

BDCA
IN

test_block(2, <<'IN', "false");
A A B B
C C B A
C A A A
B B B B

ABAC
IN

test_block(2, <<'IN', "true");
B A B A
C C C C
A B A B
B B A A

CCCAA
IN

done_testing;
