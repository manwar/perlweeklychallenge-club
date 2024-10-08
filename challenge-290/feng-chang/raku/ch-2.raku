#!/bin/env raku

unit sub MAIN(Str:D $s);

put so $s.subst(/\D/, 0).comb.map({ ++$ %% 2 ?? (2*$_).comb.sum !! $_ }).sum %% 10;
