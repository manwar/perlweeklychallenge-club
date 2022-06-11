#!/usr/bin/env raku

use Test;

is binary-tree-depth('1 | 2 3 | 4 5'), 2;
is binary-tree-depth('1 | 2 3 | 4 * * 5 | * 6'), 3;

sub binary-tree-depth($str)
{
    my $tree := $str.split(/\s\|\s/).map(*.split(/\s/));
    my $nodes = 1;
    my $depth;

    for $tree -> $elems
    {
        last unless $elems == $nodes;
        $nodes = ($nodes - $elems.comb('*')) * 2;
        $depth++;
    }

    $depth;
}
