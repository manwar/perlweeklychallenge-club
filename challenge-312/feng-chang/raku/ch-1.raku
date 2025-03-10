#!/bin/env raku

unit sub MAIN(Str:D $s);

put $s.comb».ord.rotor(2 => -1).map({ min($_, 26-$_) with abs(.[1]-.[0]) }).sum + $s.chars + 1;
