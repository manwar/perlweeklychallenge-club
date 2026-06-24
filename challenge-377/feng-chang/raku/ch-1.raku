#!/bin/env raku

unit sub MAIN(Str:D $str);

put so $str.comb.rotor(2 => -1).map({ $str.flip.contains(.join) }).any;
