#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Graph;
use experimental qw(signatures);

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [id:left:right ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    show diameter path instead of its length

id:left:right ...
    nodes of the binary tree as node id, left child, right child.
    Childs may be omitted.  The example may be specified as:
    1:2:5 2:3:4 5:6:7 7:8:10 8:9

EOS


### Input and Output

if ($verbose) {
    say "path=(@{[grep defined, tree_diameter(@ARGV)]})";
} else {
    say "diameter=", tree_diameter(@ARGV) // 0;
}


### Implementation

# Build the binary tree as a graph and return its diameter.  As we are
# allowed to move up and down the tree for a maximum length path, the
# graph has to be undirected.  The root node gets lost with this
# construction: any vertex with a degree of one or two may be taken as
# the root node.  This doesn't matter here as a diameter path need not
# pass through the root node.
sub tree_diameter (@nodes) {
    my $g = Graph->new(undirected => 1);
    for my $node (@nodes) {
        my ($id, $left, $right) = split /:/, $node;
        $g->add_edge($id, $left) if $left;
        $g->add_edge($id, $right) if $right;
    }
    # Return the diameter in scalar context, any diameter path in
    # list context or undef if there is no path at all.
    $g->diameter;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is scalar(tree_diameter(qw(1:2:5 2:3:4 5:6:7 7:8:10 8:9))),
            6, 'example 1';
    }

    SKIP: {
        skip "tests" unless $tests;
        is scalar(tree_diameter(1)), U(),
            'single root node, (here: the empty graph)';
	}

    done_testing;
    exit;
}
