#!/usr/bin/env raku

use Test;

is binary-tree-depth('1 | 2 3 | 4 5'), 2;
is binary-tree-depth('1 | 2 3 | 4 * * 5 | * 6'), 3;

sub binary-tree-depth($tree)
{
    my @tree = $tree.split(/\s\|\s/).map(*.split(/\s/));
    my $elems = 1;
    my $depth;

    while @tree
    {
        my $node = shift @tree;
        return $depth unless $node.elems == $elems;
        $elems = ($elems - $node.comb('*')) * 2;
        $depth++;
    }

    $depth;
}
