#!/usr/bin/env raku
use Tree::DAG_Node:from<Perl5>;

my $lol = [ [ [ [7], [2], 11 ], 4 ], [ [13], [ [1], 9 ], 8 ], 5 ];

my $tree = Tree::DAG_Node.lol_to_tree($lol);

$tree.walk_down({callback => &traverse});

.say for $tree.draw_ascii_tree;

sub traverse($node, $options) {
    unless ($node.daughters) {
        my @nodes = ($node.name, |(map { .name }, $node.ancestors)).reverse;
        "@nodes.join(' + ') == 22".say if @nodes.sum == 22;
    }
 
    return 1; 
}
