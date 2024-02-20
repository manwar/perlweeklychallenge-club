#!/bin/env raku

unit sub MAIN(Str:D \s1, Str:D \s2);

put roundrobin((s1, s2)».comb, :slip).join;
