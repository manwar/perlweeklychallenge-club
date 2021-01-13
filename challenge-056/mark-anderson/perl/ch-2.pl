#!/usr/bin/env perl
use Modern::Perl;
use List::Util qw/sum/;
use Tree::DAG_Node;
use feature qw/signatures/;
no warnings qw/experimental::signatures/;

my $lol = [ [ [ [7], [2], 11 ], 4 ], [ [13], [ [1], 9 ], 8 ], 5 ];

my $tree = Tree::DAG_Node->lol_to_tree($lol);

$tree->walk_down({callback => \&traverse});

say for $tree->draw_ascii_tree->@*;

sub traverse($node, $options) {
    unless ($node->daughters) {
        my @nodes = reverse ($node->name, (map { $_->name } $node->ancestors));
        say join(" + ", @nodes), " == 22" if (sum @nodes) == 22;
    }
 
    return 1; 
}
