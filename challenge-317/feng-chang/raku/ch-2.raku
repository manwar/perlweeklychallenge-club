#!/bin/env raku

unit sub MAIN(Str:D $s1, Str:D $s2);

put so (^$s1.chars).combinations(2).map({ $s1.&swap2(|$_) eq $s2 }).one;

my method swap2(Str:D $s : UInt:D $i, UInt:D $j --> Str:D) {
    my @a = $s.comb;
    @a[$j, $i] = @a[$i, $j];
    @a.join
}
