#!/usr/bin/env raku

use Test;

is binary-tree-depth('1 | 2 3 | 4 5'), 2;
is binary-tree-depth('1 | 2 3 | 4 * * 5 | * 6'), 3;
is binary-tree-depth('1 | 2 3 | 4 * * 5 | 6 * * 7 | 8 * * 9 | 10 *'), 5;

sub binary-tree-depth($str)
{
    my $tree := $str.split(/\s\|\s/).map(*.split(/\s/));
    my $elems = 1;
    my $depth = 0;

    for $tree -> $nodes
    {
        last unless $nodes.elems == $elems;
        $elems = ($elems - $nodes.comb('*')) * 2;
        $depth++;
    }

    $depth;
}
