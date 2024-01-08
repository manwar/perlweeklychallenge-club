#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [M]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M
    a matrix in any format as accepted by the PDL string constructor,
    e.g. '1,0,0;0,1,0;0,0,1'

EOS


### Input and Output

say submatrix_sum("@ARGV");


### Implementation

sub submatrix_sum {
	my $m = pdl @_;

    $m->range(ndcoords($m(1:,1:)), 2)->reorder(2, 3, 0, 1)
        ->clump(2)->sumover;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is submatrix_sum(
            [1,  2,  3,  4],
            [5,  6,  7,  8],
            [9, 10, 11, 12])->unpdl,
            [[14, 18, 22], [30, 34, 38]], 'example 1';

        is submatrix_sum(
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1])->unpdl,
            [[2, 1, 0], [1, 2, 1], [0, 1, 2]], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
