#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [MATRIX]

-examples
    run the examples from the challenge
 
-tests
    run some tests

MATRIX
    a square matrix in any form accepted by the PDL string constructor,
    e.g. '[ [1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1] ]'

EOS


### Input and Output

say +(qw(false true))[is_x("@ARGV")];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/04/26/ch-266.html#task-2


sub is_x {
	my $m = pdl @_;
    my ($on_x, $off_x) = $m->where_both(identity($m) | identity($m)->(-1:0));

    all($on_x) && !any($off_x);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is is_x([ [1, 0, 0, 2],
                  [0, 3, 4, 0],
                  [0, 5, 6, 0],
                  [7, 0, 0, 1],
                ]), T(), 'example 1';

        is is_x([ [1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9],
                ]), F(), 'example 2';

        is is_x([ [1, 0, 2],
                  [0, 3, 0],
                  [4, 0, 5],
                ]), T(), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is is_x([ [1, 0, 0, 2],
                  [0, 3, 4, 0],
                  [0, 5, 6, 0],
                  [7, 0, 0, 0],
                ]), F(), 'zero on X';

        is is_x([ [1, 0, 0, 2],
                  [0, 3, 4, 0],
                  [0, 5, 6, 1],
                  [7, 0, 0, 1],
                ]), F(), 'nonzero off X';
	}

    done_testing;
    exit;
}
