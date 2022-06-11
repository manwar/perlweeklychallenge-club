#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Graph;
use List::AllUtils qw(min natatime);
use experimental qw(signatures postderef);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N11 | N21 N22 | ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1 | N11 N12 | ...
    String representation of the binary tree with N1 as the root node
    and Nx1, Nx2 as the left and right child nodes of Nx.  Missing nodes
    are represented by an asterisk and may be omitted at the end of a
    level.  Child nodes without a parent are ignored.

EOS


### Input and Output

# Split levels and nodes, create the graph and find the minimum
# depth.
say min_depth(build_graph(map [split], split /\s*\|\s*/, $ARGV[0]));


### Implementation

# Splitting the task in two:
# - Create a binary tree from a node list for each tree level
# - Find the minimum depth from the root node to any leaf node

# Create a directed graph from an AoA.  Each row holds the identifiers
# for a tree level, where an asterisk represents a missing node.
# Using a directed graph as a binary tree representation.
sub build_graph (@nodes) {
    my $g = Graph->new(directed => 1);
    # Add the root node as it might be single.
    $g->add_vertex($_) for existing($nodes[0][0]);
    while (@nodes > 1) {
        # Create an iterator for child nodes.
        my $children = natatime 2, $nodes[1]->@*;
        # Add existing child nodes to existing parent nodes.
        for my $p (existing(@{shift @nodes})) {
            $g->add_edge($p, $_) for existing($children->());
        }
    }

    $g;
}

# Helper sub to filter out non-existing nodes.
sub existing {
    grep !/^\*$/, @_;
}

# Find the minimum depth in a tree-like graph from its root.
sub min_depth ($g) {
    # Use zero as the depth of an empty tree.
    return 0 unless $g->has_vertices;
    # Find the (unique) root vertex.
    my $root = ($g->source_vertices)[0];
    # Use one as the depth of a root-only tree.  (An isolated vertex
    # does not count as a source vertex.)
    return 1 unless defined $root;
    # Create the tree of Single-Source Shortest Paths originating at the
    # root vertex.
    my $sptg = $g->SPT_Dijkstra($root);

    # Find the shortest path from the root to all leafs (i.e. sink
    # vertices) and take the minimum thereof.  As the depth is defined
    # here as the number of vertices in the path instead of the number
    # of edges, we need to add one for the desired result.
    1 + min map $sptg->get_vertex_attribute($_, 'weight'),
        $sptg->sink_vertices;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is min_depth(build_graph([1], [qw(2 3)], [qw(4 5)])), 
            2, 'example 1';
        is min_depth(build_graph([1], [qw(2 3)], [qw(4 * * 5)], [qw(* 6)])),
            3, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is min_depth(Graph->new), 0, 'empty tree';
        is min_depth(Graph->new->add_vertex('1')), 1, 'single root';
        is min_depth(Graph->new->add_vertex('0')), 1, 'single zero root';
        is min_depth(build_graph(['*'])), 0, 'no root';
        is min_depth(build_graph([0], [1])), 2, 'zero as root label';
        is min_depth(build_graph([1], [0])), 2, 'zero as child label';
#   Example tree:
#         1
#        / \
#       2   3
#      /   / \
#     4   5   6
#    /   / \
#   7   8   9
#      / \   \
#     10 11  12
#     /      /
#    13     14
#   String representation:
#   '1 | 2 3 | 4 * 5 6 | 7 * 8 9 | * * 10 11 * 12 | 13 * * * 14' 
    is min_depth(build_graph([1], [qw(2 3)], [qw(4 * 5 6)],
        [qw(7 * 8 9)], [qw(* * 10 11 * 12)], [qw(13 * * * * 14)])), 3,
        'leafs at multiple depths';
     
	}

    done_testing;
    exit;
}
