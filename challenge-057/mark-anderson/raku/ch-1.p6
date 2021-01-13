#!/usr/bin/env raku

use Tree::DAG_Node:from<Perl5>;

my $lol = ((4,5,2), (6,7,3), 1);

my $tree = Tree::DAG_Node.lol_to_tree($lol);

.say for $tree.draw_ascii_tree;

$tree.walk_down({callback => &swap-nodes});

.say for $tree.draw_ascii_tree;

sub swap-nodes($node, $options) {
    if $node.daughters.elems > 1 {
       $node.set_daughters($node.daughters[1], $node.daughters[0]);
    }

    return 1;
};
