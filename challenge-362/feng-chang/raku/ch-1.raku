#!/bin/env raku

unit sub MAIN(Str:D $s where 'a' le *.comb.all le 'z');

put $s.comb.map(* x ++$).join;
