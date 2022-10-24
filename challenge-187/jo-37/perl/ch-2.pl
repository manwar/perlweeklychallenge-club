#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    List of numbers.

EOS


### Input and Output

main: {
    local $" = ', ';
    say "(@{[mp_triangle(@ARGV)]})";
}


### Implementation

# Demystifying the task: There is no magic in triples satisfying the
# given inequalities.  These are just edges that form a non-degenerated
# triangle.  The task may be formulated as finding the triangle having a
# maximum perimeter from a given set of edges.
# Note: There is no triangle in any sequence growing at least like a
# Fibonacci sequence.
sub mp_triangle {
    # Sort descending.
	my @e = sort {$b <=> $a} @_;
    while () {
        # There is no triangle, if there is no smallest edge having
        # a positive length.
        return () unless ($e[2] // 0) > 0;
        # If the largest three numbers form a triangle, it has a maximum
        # perimeter.
        return @e[0, 1, 2] if $e[0] < $e[1] + $e[2];
        # If the largest three edges do not form a triangle then there
        # is no triangle including the largest edge at all.  Drop it.
        shift @e;
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [mp_triangle(1, 2, 3, 2)], [3, 2, 2], 'example 1';
        is [mp_triangle(1, 3, 2)], [], 'example 2';
        is [mp_triangle(1, 1, 2, 3)], [], 'example 3';
        is [mp_triangle(2, 4, 3)], [4, 3, 2], 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [mp_triangle(1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144)], [], 
            'no triangle from Fibonacci numbers';

        is [mp_triangle(1, 2, 2, 3, 4, 6, 9, 14, 22, 35)],
            [35, 22, 14], 'F(N) = F(N-2) + F(N-1) - 1';
	}

    done_testing;
    exit;
}
