#!/bin/env raku

multi infix:<加>([], $B) { $B }

multi infix:<加>($A, [0]) { $A }

multi infix:<加>($A, [1]) {
    my Array $C = $A;

    if $C[*-1] == 0 {
        $C.splice(*-1, 1, 1);
    } else {
        $C.pop;
        $C 加= [1];
        $C.push(0);
    }

    $C
}

multi infix:<加>($A, $B) {
    my Array $C = $A.elems ≥ $B.elems - 1 ?? $A[^($A.elems - $B.elems + 1)].Array !! [];
    for $B.elems ... 1 -> $i {
        $C 加= [$B[$B.elems - $i]];
        $C.push(0 ≤ $A.elems - $i + 1 < $A.elems ?? $A[$A.elems - $i + 1] !! 0) if $i > 1;
    }

    $C
}

sub MAIN(UInt:D $a, UInt:D $b) {
    put ($a.comb».UInt.Array 加 $b.comb».UInt.Array).join;
}
