#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $n = <>) {
    if ($n < 32) {
        #
        # No solutions exist for $n < 32 (see https://oeis.org/A071984).
        # There *are* solutions if there is no requirement if the 
        # first and last number sum to a square (https://oeis.org/A090460).
        #
        # Solutions exists for all $n >= 32.
        #
        say "";
        next;
    }

    #
    # Build a graph. Vertices are numbers 1 .. $n. There is an
    # edge between nodes i and j, iff i + j is a square.
    # Node that the maximum sum between two numbers is 2 * $n + 1.
    #
    my @graph;
    my %squares = map {($_ * $_) => 1} 1 .. int sqrt (2 * $n - 1);
    for (my $i = 1; $i < $n; $i ++) {
        for (my $j = $i + 1; $j <= $n; $j ++) {
            if ($squares {$i + $j}) {
                push @{$graph [$i]} => $j;
                push @{$graph [$j]} => $i;
            }
        }
    }

    #
    # Find a Hamiltonian cycle. Since we're searching for a cycle,
    # we can start at any vertix. We pick 1 as the starting vertex.
    # We will use a DFS, and stop at the first cycle we find.
    #
    my @todo = ([1]);   # List of vertices
    while (@todo) {
        my $path = pop @todo;
        if (@$path == $n) {
            #
            # This path is Hamiltonian, as it visits all vertices.
            # If we can close the path into a cycle, we have
            # a winner, and will not continue.
            #
            if ($squares {$$path [0] + $$path [-1]}) {
                say "@$path";
                last;
            }
            next;
        }
        #
        # We haven't visited all vertices yet. Try extended the path
        # with all outgoing edges, but only those which lead to 
        # an unvisited vertex.
        #
        my %seen = map {$_ => 1} @$path;
        my $last_vertex = $$path [-1];
        foreach my $next_vertex (@{$graph [$last_vertex]}) {
            next if $seen {$next_vertex};
            push @todo => [@$path => $next_vertex];
        }
    }
}


__END__
