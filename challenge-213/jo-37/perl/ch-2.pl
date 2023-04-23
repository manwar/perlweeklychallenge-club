#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Graph::Undirected;
use List::MoreUtils 'slide';
use experimental 'signatures';

our ($tests, $examples, $source, $dest);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-source=S] [-dest=D] [N1,N2,... ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-source=S
    source node

-dest=D
    destination node

N1,N2,... ...
    list of routes, the nodes of each route are comma separated

EOS


### Input and Output

main: {
    local $" = ',';
    say "(@{shortest_route($source, $dest, map [split /,/], @ARGV)})";
}


### Implementation

sub shortest_route ($source, $dest, @routes) {
	my $g = Graph::Undirected->new;
    slide {$g->add_edge($a, $b)} @$_ for @routes;

    [$g->SP_Dijkstra($source, $dest)];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is shortest_route(1, 7, [1, 2, 6], [5, 6, 7]), [1, 2, 6, 7],
            'example 1';
        is shortest_route(2, 5, [1, 2, 3], [4, 5, 6]), [], 'example 2';
        is shortest_route(1, 7, [1,2,3], [4,5,6], [3,8,9], [7,8]),
            [1,2,3,8,7], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
