#!/bin/env raku

unit sub MAIN(Str:D $s, UInt:D $size);

put $s.comb.grep(* ne '-').reverse.rotor($size, :partial).map(*.reverse.join).reverse.join('-');
