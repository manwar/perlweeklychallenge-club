#!/bin/env raku

unit sub MAIN(Str:D $s);

put $s.comb».ord.rotor(2 => -1).map({ [-] $_ })».abs.sum;
