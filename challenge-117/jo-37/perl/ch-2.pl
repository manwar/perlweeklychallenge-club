#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Graph;
use experimental qw(signatures postderef);

our ($tests, $examples, $triangle, $from, $to);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV && defined($from) && defined($to) || $triangle;
usage: $0 [-examples] [-tests] [-triangle=n | -from=v_f -to=v_t edge ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-triangle=n
    build triangular graph having size n

-from=v_f
    use v_f as starting vertex

-to=v_t
    use v_t as ending vertex

edge ...
    specify the graph by its edges.  Each edge has the form
    'h-t-l' with 'h' as the head vertex, 't' as the tail vertex and
    'l' as the edge label.

    Example 1 may have these vertex assignments:

        a
       ⇙ ⇘
      b ⇒ c
     ⇙ ⇘ ⇙ ⇘
    d ⇒ e ⇒ f

    and it may be run as:

    $0 -from=a -to=f a-b-L a-c-R b-c-H b-d-L b-e-R c-e-L c-f-R d-e-H e-f-H

    or simply:

    $0 -triangle=2

EOS


### Input and Output

my $g;
if ($triangle) {
    $g = graph_from_edges(triangle($triangle));
    $from = "0 0";
    $to = "$triangle $triangle";
} else {
    $g = graph_from_edges([@ARGV]);
}

say "@{paths_from_to($g, $from, $to)}";


### Implementation

# For a highly regular graph as given in the task there is certainly a
# pattern in the solution that permits its straight construction.  As a
# lame excuse for not searching for such pattern, I'm going to solve a
# more general task.
# Considering a directed acyclic graph (DAG) with labeled edges.
# Then find all paths between a given start and end vertex and print the
# concatenated edge labels for every path.
#
# This easily earns the N=10-bonus.
#
# Having implemented the lazy solution, it provides the sequence of
# the count of possible paths for a given triangle size as:
# 2, 6, 22, 90, 394, 1806,...
# Consulting OEIS reveals this sequence as the "Large Schröder Numbers".
# See http://oeis.org/A006318 and
# https://en.wikipedia.org/wiki/Schröder_number.  Not even thinking
# about generating the 17518619320890 paths for N=20.

# Find all paths in the given DAG starting in vertex $from and ending in
# vertex $to and collect the concatenated edges' labels.
sub paths_from_to ($g, $from, $to) {
    # Apply a single empty prefix to the start vertex.
    my %paths = ($from => ['']);
    # Process vertices in topological order.
    for my $vertex ($g->topological_sort) {
        # At the end vertex all paths from the start vertex are known
        # due to the topological ordering.
        return $paths{$vertex} if $vertex eq $to;
        # For every outgoing edge append the edge's label to the label
        # sequence for all paths leading to the current vertex and then
        # append this list to the path list for the edge's tail vertex.
        # This is a no-op until the start vertex is hit.
        for my $succ ($g->successors($vertex)) {
            my $label = $g->get_edge_attribute($vertex, $succ, 'label');
            push $paths{$succ}->@*, map $_ . $label, $paths{$vertex}->@*;
        }
    }
}

# Build a graph from its labeled edges.  Edges are expected in the
# form "h-t-l" with "h" as the head vertex, "t" as the tail vertex and
# "l" as the label.
sub graph_from_edges ($edges) {
    my $g = Graph->new;
    for (@$edges) {
        my ($h, $t, $l) = split /-/;
        $g->set_edge_attribute($h, $t, label => $l);
    }
    die "not a DAG\n" unless $g->is_dag;

    $g;
}

# Generate the edges for a triangular graph of size $n according to the
# task.  Edges have the form "head-tail-label", vertices have the form
# "row col"
sub triangle ($n) {
    my @edges;
    for my $row (0 .. $n) {
        for my $col (0 .. $row) {
            my @vert = ($row, $col);
            if ($col < $row) {
                my @horiz = ($row, $col + 1);
                push @edges, "@vert-@horiz-H";
            }
            if ($row < $n) {
                my @left = ($row + 1, $col);
                my @right = ($row + 1, $col + 1);
                push @edges, "@vert-@left-L", "@vert-@right-R";
            }
        }
    }

    \@edges;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is paths_from_to(graph_from_edges(triangle(2)), '0 0', '2 2'),
            bag {
                item 'RR';
                item 'LHR';
                item 'LRH';
                item 'RLH';
                item 'LHLH';
                item 'LLHH';
                end;
            }, 'example 1';

        is paths_from_to(graph_from_edges(triangle(1)), '0 0', '1 1'),
            bag {
                item 'R';
                item 'LH';
                end;
            }, 'example 2';

        is scalar(@{paths_from_to(
                graph_from_edges(triangle(10)), '0 0', '10 10')}
            ), 1037718, 'N=10';


    }

    SKIP: {
        skip "tests" unless $tests;

#    A less regular DAG as a test object with two source vertices.
#
#        a
#       ⇙ ⇘
#      b   c   d
#     ⇙ ⇘ ⇙ ⇘ ⇙ ⇘
#    e ⇐ f   g ⇐ h
#     ⇘ ⇙ ⇘ ⇙ ⇘ ⇙
#      i   j   k
#       ⇘ ⇙
#        l

        my $g = graph_from_edges([qw(
                a-b-L a-c-R
                b-e-L b-f-R c-f-L c-g-R d-g-L d-h-R
                e-i-R f-e-H f-i-L f-j-R g-j-L g-k-R h-g-H h-k-L
                i-l-R j-l-L)]);

        is paths_from_to($g, 'a', 'k'), ['RRR'], 'unique path';
        is paths_from_to($g, 'b', 'k'), [], 'not reachable';
        is paths_from_to($g, 'j', 'c'), [], 'out of topological order';

        like dies {graph_from_edges([qw(a-b-D b-a-U)])}, qr/not a DAG/,
            'not a directed acyclic graph';

	}

    done_testing;
    exit;
}
