#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples, $diff);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless defined $diff && @ARGV > 2;
usage: $0 [-examples] [-tests] [-diff=D N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-diff=D
    count arithmetic triplets having a difference of D

N...
    three or more integers

EOS


### Input and Output

say arith_triplets($diff, @ARGV);


### Implementation

# Using graph theory to solve the task.  We take the given integers as
# the vertices of a directed graph with their indices as unique
# identifiers and the integers as values.  Two vertices are connected
# with an edge if and only if the indices are in correct order and the
# difference between the values equals the given difference.
#
# The adjacency matrix of a graph shows all edges, i.e. direct
# neighboring vertices.  Furthermore, the squared adjacency matrix shows
# the number of 2-walks between any two vertices.  In the constructed
# "forward only" graph every walk is actually a path, each 2-path
# corresponds to one arithmetic triplet for the given difference and the
# sum over the elements of this squared matrix is the requested number
# of arithmetic triplets.
#
# There is neither a need for the numbers to be in increasing order nor
# for the difference to be positive.

sub arith_triplets {
    my $diff = shift;
	my $l = long @_;
    # Build the adjacency matrix.
    my $adj =
        (sequence($l) > sequence($l)->dummy(0))
        & ($l - $l->dummy(0) == $diff);
        
    # Count the number of 2-paths in the graph.
    ($adj x $adj)->sum;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is arith_triplets(3 ,=> 0, 1, 4, 6, 7, 10), 2, 'example 1';
        is arith_triplets(2 ,=> 4, 5, 6, 7, 8, 9), 2, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is arith_triplets(1 ,=> 1, 2, 4, 5, 8, 9), 0, 'no triplet';
        is arith_triplets(2 ,=> 1, 3, 3, 5), 2, 'multiple paths';
        is arith_triplets(1 ,=> 9, 1, 8, 2, 7, 3), 1, 'not ordered';
        is arith_triplets(0 ,=> 1, 2, 1, 4, 1, 6), 1, 'zero diff';
        is arith_triplets(-1 ,=> 4, 3, 2, 1), 2, 'negative diff';
	}

    done_testing;
    exit;
}
