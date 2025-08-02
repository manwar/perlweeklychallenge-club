#! /usr/bin/raku

use Test;

plan 3;

is(equalstrings(['abc', 'abb', 'ab']), 2, 'example 1');
is(equalstrings(['ayz', 'cyz', 'xyz']), -1, 'example 2');
is(equalstrings(['yza', 'yzb', 'yzc']), 3, 'example 3');

sub equalstrings(@a) {
    my $ax = Set.new(@a);
    my @ca;
    for $ax.keys -> $x {
        @ca.push($x.comb.Array);
    }
    my $mmlen = min(@ca.map({$_.elems}));
    my $si = 0;
    for (0 ..^ $mmlen) -> $i {
        $si = $i;
        for (1 ..^ @ca.elems) -> $s {
            if (@ca[0][$i] ne @ca[$s][$i]) {
                if ($i == 0) {
                    return -1;
                }
                $si -= 1;
                last;
            }
        }
    }
    sum(@a.map({$_.chars})) - @a.elems * ($si + 1);
}
