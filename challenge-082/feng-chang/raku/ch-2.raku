#!/bin/env raku

sub interleave-string($a, $b, $c --> UInt)  {
    if $c.elems == 0 {
        return ($a.elems | $b.elems) > 0 ?? 0 !! 1;
    }

    return 0 if ($a[0] // '', $b[0] // '').none eq $c[0];

    if $c[0] eq ($a[0] // '') {
        return 1 if interleave-string($a.tail(*-1), $b, $c.tail(*-1)) == 1;
    }

    if $c[0] eq ($b[0] // '') {
        return interleave-string($a, $b.tail(*-1), $c.tail(*-1));
    } else {
        return 0;
    }
}

sub MAIN(Str:D $A, Str:D $B, Str:D $C) {
    say interleave-string($A.comb.List, $B.comb.List, $C.comb.List);
}
