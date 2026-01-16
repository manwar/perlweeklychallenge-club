#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote("Hello World         ")." ".quote("d"),  1);
test_line(1, quote("apple banana cherry ")." ".quote("ae"), 0);
test_line(1, quote("Coding is fun       ")." ".quote(""),   3);
test_line(1, quote("The Weekly Challenge")." ".quote("ab"), 2);
test_line(1, quote("Perl and Python     ")." ".quote("p"),  1);

test_line(2, "programming g",   "gorpramming");
test_line(2, "hello       h",   "hello");
test_line(2, "abcdefghij  h",   "hgfedcbaij");
test_line(2, "reverse     s",   "srevere");
test_line(2, "perl        r",   "repl");

done_testing;
