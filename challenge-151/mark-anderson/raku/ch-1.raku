#!/usr/bin/env raku

use Test;

is binary-tree-depth('1 | 2 3 | 4 5'), 2;
is binary-tree-depth('1 | 2 3 | 4 * * 5 | * 6'), 3;

sub binary-tree-depth($tree)
{
    my @tree = $tree.split(/\s\|\s/).map(*.split(/\s/));
    my $elems = 1;
    my $depth = 0;

    while @tree
    {
        my $nodes := shift @tree;
        return $depth unless $nodes.elems == $elems;
        $elems = ($elems - $nodes.comb('*')) * 2;
        $depth++;
    }

    $depth;
}
