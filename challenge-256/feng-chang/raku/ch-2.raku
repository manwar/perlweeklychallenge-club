#!/bin/env raku

unit sub MAIN(Str:D \s1, Str:D \s2);

my \len = (s1, s2)».chars.min;
put (s1.comb Z~ s2.comb).join ~ substr(s1, len) ~ substr(s2, len);
