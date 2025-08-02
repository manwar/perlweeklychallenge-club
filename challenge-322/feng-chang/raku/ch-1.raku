#!/bin/env raku

unit sub MAIN(Str:D $s, UInt:D $size);

put $s.flip.comb(/<-[-]>/).rotor($size, :partial).map(*.join).join('-').flip;
