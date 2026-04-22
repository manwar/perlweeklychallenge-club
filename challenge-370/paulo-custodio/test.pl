#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN', <<'OUT', "");
Bob hit a ball, the hit BALL flew far after it was hit.
hit
IN
ball
OUT
test_block(1, <<'IN', <<'OUT', "");
Apple? apple! Apple, pear, orange, pear, apple, orange.
apple pear
IN
orange
OUT
test_block(1, <<'IN', <<'OUT', "");
A. a, a! A. B. b. b.
b
IN
a
OUT
test_block(1, <<'IN', <<'OUT', "");
Ball.ball,ball:apple!apple.banana
ball
IN
apple
OUT
test_block(1, <<'IN', <<'OUT', "");
The dog chased the cat, but the dog was faster than the cat.
the dog
IN
cat
OUT

test_line(2, "abc acb",     "true");
test_line(2, "abcd cdba",   "true");
test_line(2, "hello hiiii", "false");
test_line(2, "ateer eater", "true");
test_line(2, "abcd bdac",   "false");
test_line(2, "abcd adcb",   "true");
test_line(2, "abcde caebd", "false");

done_testing;
