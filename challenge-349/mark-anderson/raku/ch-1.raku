#!/usr/bin/env raku
use Test;

is power-string("textbook"),             2;
is power-string("aaaaa"),                5;
is power-string("hoorayyy"),             3;
is power-string("x"),                    1;
is power-string("aabcccddeeffffghijjk"), 4;

sub power-string($str) { ($str ~~ m:g/(.) $0*/)>>.chars.max }
