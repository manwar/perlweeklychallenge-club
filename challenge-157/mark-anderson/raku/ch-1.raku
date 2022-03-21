#!/usr/bin/env raku

say pyth-means([1, 3, 5, 6, 9]);
say pyth-means([2, 4, 6, 8, 10]);
say pyth-means([1, 2, 3, 4, 5]);

sub pyth-means(@n)
{
    (([+] @n) / @n.elems).fmt("%.1f"),
    (([*] @n) ** (1/@n.elems)).fmt("%.1f"),
    ((@n.map(* ** -1).sum / @n.elems) ** -1).fmt("%.1f")
}
