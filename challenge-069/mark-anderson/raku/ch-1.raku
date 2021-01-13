#!/usr/bin/env raku

sub MAIN(UInt $A, UInt $B where 1 <= $A <= $B <= 10**6) {
    for $A..$B -> $num {
        next if $num ~~ /<-[01689]>/;
        say $num if $num.flip.trans("69" => "96") eq $num;
    }
}
