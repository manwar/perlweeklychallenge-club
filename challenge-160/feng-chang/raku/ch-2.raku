#!/bin/env raku

unit sub MAIN(*@n);

for ^@n.elems -> $i {
    my $idx;
    FIRST { $idx = -1 }

    if @n[^$i].sum == @n[$i ^.. *].sum {
        $idx = $i;
        last;
    }

    LAST { put $idx }
}
