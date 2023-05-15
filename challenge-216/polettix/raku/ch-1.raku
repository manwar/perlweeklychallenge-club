#!/usr/bin/env raku
use v6;
sub MAIN (Str :$code, *@words) {
   my @code = $code.lc.subst(/ <-[ a..z ]>/, '', :g).comb.Set;
   @words.grep({ @code ⊆ .lc.comb }).join(', ').put;
}
