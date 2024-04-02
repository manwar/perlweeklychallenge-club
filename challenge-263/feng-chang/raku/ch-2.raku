#!/bin/env raku

unit sub MAIN(Str:D $s1, Str:D $s2);

use MONKEY-SEE-NO-EVAL;

my @items = EVAL "$s1, $s2";
my %merged;
%merged{$_[0]} += $_[1] for @items;
put %merged.keys.sort.map({ [ +$_, %merged{$_} ] }).Array.raku;
