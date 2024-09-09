#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Graph::Directed;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [ROUTE...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

ROUTE...
   routes given as origin-destination, e.g A-B 

EOS


### Input and Output

say for no_connection(map [split qr/-/, $_], @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/09/06/ch-285.html#task-1


sub no_connection {
    Graph::Directed->new(edges => \@_)->sink_vertices;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [no_connection(["B","C"], ["D","B"], ["C","A"])], ["A"],
            "example 1";
        is [no_connection(["A","Z"])], ["Z"],
            "example 2";
    }

    SKIP: {
        skip "tests" unless $tests;

        is [no_connection(["A", "B"], ["B", "C"], ["C", "A"])], [], 'cycle';
	}

    done_testing;
    exit;
}
