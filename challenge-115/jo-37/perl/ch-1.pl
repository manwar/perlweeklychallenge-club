#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Graph;
use List::Util 'first';
use List::MoreUtils 'firstidx';
use utf8;
use Unicode::Normalize;
use experimental qw(signatures postderef);

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [string ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    show a string circle if there is one

string ...
    try to chain given strings into a circle

EOS


### Input and Output

say 0 + !!has_string_circle(@ARGV);


### Implementation

# Interpreting the task as follows:
# *Decide* if there is a single circle connecting all given strings.
# I.e.  multiple disjoint cycles do not count nor a single cycle that
# does not contain all given strings.  A *concrete* circle is not
# requested.
#
# With this interpretation, the task is equivalent to deciding if the
# multidigraph formed by the given strings is Eulerian, where each
# string represents a directed edge between the vertices identified by
# the string's first and last character.  Particularly, there may be
# multiple (equally directed) edges between the same pair of vertices
# and there may be loops connecting a vertex to itself.

# According to Euler-Hierholzer's Theorem (in its extension for
# multidigraphs), an Eulerian cycle exists if and only if the graph
# (ignoring isolated vertices) is strongly connected and every vertex
# has a degree of zero, where the degree is the difference between
# in-degree and out-degree.
#
# Note: This theorem is given in several places without quoting its
# origin and is sometimes attributed to "Good".  For a proof and some
# discussion see below.
#
# References:
# https://en.wikipedia.org/wiki/Eulerian_path
# https://en.wikipedia.org/wiki/Directed_graph
# https://en.wikipedia.org/wiki/Multigraph
# Even more details in the corresponding German wiki pages.

sub has_string_circle {
    # Create a multidigraph from the strings.
    my $g = Graph->new(multiedged => 1);
    for (@_) {
        # The core of a multidigraph: Map each edge to its source and
        # target vertices.  This construction ensures that there are no
        # isolated vertices.
        # Get the string's first and last character, even if there's
        # only one.  Convert to lowercase normalized form allowing
        # case-insensitive chaining of extended grapheme clusters as
        # first and last "characters".
        my @e = map NFD(lc), /^(\X)/, /(\X)$/;
        my $id = $g->add_edge_get_id(@e);
        # Assign the string as an edge attribute if an actual string
        # circle is requested.
        $g->set_edge_attribute_by_id(@e, $id, str => $_) if $verbose;
    }

    # The "Graph" package's method "is_strongly_connected" dies if
    # applied to a multigraph.  The corollary below offers a
    # simple workaround: Checking the weak connectivity suffices and
    # "is_weakly_connected" appears to work for multigraphs.
    return unless $g->is_weakly_connected;

    # Check the degree of all vertices.
    for my $v ($g->vertices) {
        return if $g->vertex_degree($v);
    }

    # Here the graph is Eulerian.

    # Construct and display a string circle if requested.
    build_circle($g) if $verbose;

    return 1;
}

# Implementation of Hierholzer's algorithm (see below for a
# justification):
# - Start with a random vertex v.
# - Build a cycle c starting from and ending in v.
# - Repeat:
#   * Find a new vertex v1 in c that has an outgoing edge excluded
#     from c.
#   * If there is no such vertex, the cycle c is Eulerian. Stop.
#   * Find a cycle c1 starting from and ending in v1, omitting all edges
#     in c.
#   * Join the cycle c1 with the existing cycle c.
sub build_circle ($g) {
    my @circle;
    # Pick a random start vertex.  Loop while there is a vertex with an
    # unselected outgoing edge.
    for (my $v = ($g->vertices)[0];
            defined $v; 
            $v = first {$g->out_degree($_)} map $_->[0], @circle) {
        # Find the vertex position in the (non-)existing circle.
        my $vpos = @circle ? firstidx {$_->[0] eq $v} @circle : 0;
        # Find a cycle through $v and join it with the circle.
        splice @circle, $vpos, 0, @{extract_cycle($g, $v)};
    }

    do {local $, = ', '; say map qq{"$_->[1]"}, @circle};
}

# Find a cycle starting from and ending in $vertex and remove the
# selected edges on the way.
sub extract_cycle ($g, $vertex) {
    my $v = $vertex;
    my @cycle;
    do {
        # Select a random outgoing multi-edge.
        my @e = ($g->edges_from($v))[0]->@*;
        # Select a random edge from the multi-edge.
        my $id = ($g->get_multiedge_ids(@e))[0];
        # Collect the edge's source vertex and the string.
        push @cycle, [$e[0], $g->get_edge_attribute_by_id(@e, $id, 'str')];
        # Remove the selected edge from the graph.
        $g->delete_edge_by_id(@e, $id);
        # Advance to the target vertex.
        $v = $e[1];
    } until ($v eq $vertex);

    \@cycle;
}


### Examples and tests

sub run_tests {

    SKIP: {
        skip "examples" unless $examples;

        is has_string_circle(qw(abc dea cd)), T(), 'example 1';
        is has_string_circle(qw(ade cbd fgh)), F(), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is has_string_circle(qw(ab bc ca bd de eb)), T(),
            'has two cycles';
        is has_string_circle(qw(ab bc ca bc)), F(), 'remaining string';
        is has_string_circle(qw(ab ba cd dc)), F(), 'not connected';
        is has_string_circle(qw(ab bc ca ad de ed)), F(),
            'weakly connected, nonzero degree';
        is has_string_circle(qw(ab ba c)), F(), 'disconnected self loop';
        is has_string_circle(qw(ab bc ca bd de eb axb bxc cxa d 0a a0 0)),
            T(),
            'the whole works: multi-edged, loops, single char, zero vertex';
        # This would fail for "yolk", "eyelet", "gust", "O-umlaut" :-)
        is has_string_circle(qw(Eigelb Öse Bö), "O\x{308}"), T(),
            'mixed case unicode grapheme cluster';
	}

    done_testing;
    exit;
}

__END__

Theorem ("Good"?):

For a multidigraph D the following two statements are equivalent:
(a) D is Eulerian
(b) The subgraph of D ignoring isolated vertices is strongly connected
    and every vertex of D has a degree of zero.

Note: a vertex solely connected to itself by loop edges has ingoing and
outgoing edges and thus is not isolated.

Proof:

(1): Show that (a) implies (b)

As D has an Eulerian circle, each non-isolated vertex is visited in the
course of the circle and as this is a circle, every non-isolated vertex
is reachable from any other non-isolated vertex.  Thus D without its
isolated vertices is strongly connected.

A circle has no ending vertex, thus for every vertex in the circle
there is an outgoing edge for every incoming edge, which gives a degree
of zero for every vertex.  (This holds for isolated vertices, too.)

(2): Show that (b) implies (a)

This is basicly the reasoning for Hierholzer's algorithm.

Select any (non-isolated) vertex v in D and build an arbitrary walk w
starting in v.  Because every vertex has a degree of zero this walk may
be augmented in every vertex it ends in and because the graph is finite
it must lead back to v.  If there are no edges omitted by the
constructed walk, this walk is an Eulerian circle.  Otherwise, from the
strong connectivity of D it follows, that there must be a vertex v1 in w
having an outgoing edge that is not part of w.  Constructing a new walk
w1 starting in v1 taking the omitted outgoing edge and augmenting this
with omitted edges only will - following the same consideration - lead
back to v1.  The newly constructed walk w1 thus has no common edge with
w an can be inserted into the existing walk at the vertex v1.

Repeating the procedure for the extended walk leads to a sequence of
strictly growing walks, which must result in an Eulerian circle as the
graph is finite.

Q.E.D.


Corollary:
"strongly connected" may be replaced with "weakly connected".

Indeed:
In part (1) this is trivial as a strongly connected graph is weakly
connected, too. 
In part (2) the existence of an *outgoing* edge from a vertex in w is a
consequence of the strong connectivity.  Assuming a weakly connected
graph would ensure the existence of an incoming *or* outgoing edge only.
From the zero degree of each vertex it follows, that for an incoming
egde there must be a corresponding outgoing edge.
Thus we may presume a weakly connected graph and will always find a
strongly connected graph.
