#!/bin/env raku

unit sub MAIN(*@n);

for ^@n.elems -> $i {
    my $ind = -1;

    if @n[^$i].sum == @n[$i ^.. *].sum {
        $ind = $i;
        last;
    }

    LAST { put $ind }
}
