#!/bin/env raku

unit sub MAIN(UInt:D $int is copy, UInt:D $len where $len < $int.chars);

repeat {
    $int = +$int.comb(/<digit> ** {1..$len}/).map({ .comb.sum }).join;
} until $int.chars ≤ $len;
put $int;
