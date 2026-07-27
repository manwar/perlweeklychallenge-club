#!/usr/bin/env raku
use Test;

is special-binary-string("0101"),     <01 10 01>;
is special-binary-string("000111"),   <000111 0011 01>;
is special-binary-string("000011"),   <0011 01>;
is special-binary-string("10011100"), <10 0011 01 1100 10>;
is special-binary-string("00000"),    Empty;

sub special-binary-string($b)
{
    ($b ~~ m:ov/ [ (0+)(1+) || (1+)(0+) ] <?{ $0.chars == $1.chars }> /)>>.Str
}
