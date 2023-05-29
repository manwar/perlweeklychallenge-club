#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use Math::Prime::Util 'fromdigits';
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [--] [...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

M
    matrix from zeroes and ones in any form accepted by the PDL string
    constructor, e.g.
    "[ [0,0,1,1], [1,0,1,0], [1,1,0,0], ]"

EOS


### Input and Output

say matrix_score(byte "@ARGV");


### Implementation

# The matrix is maximal w.r.t. row toggles if the first column is
# all-ones.  Any toggled row would decrease the overall sum.
# The matrix is maximal w.r.t. column toggles, if all columns have at
# least as many ones as zeroes.  Toggling a column having an equal
# number of zeroes and ones would not change the overall sum whereas the
# overall sum would decrease otherwise.

sub matrix_score ($b) {
    say "inititial:", $b if $verbose;
    
    # Toggle all rows having a zero in the first column.
    $b ^= !$b(0);
    say "intermediate:", $b if $verbose;
    
    # Toggle all columns having less ones than zeroes.
    $b ^= $b->xchg(0, 1)->sumover < $b->dim(1) / 2;
    say "final:", $b if $verbose;

    # Fromdigits accepts digits of any size, thus there is no need to
    # calculate the individual numbers.
    fromdigits $b->xchg(0, 1)->sumover->unpdl, 2;
}


### Examples and tests

sub run_tests {
    local $verbose;

    SKIP: {
        skip "examples" unless $examples;

        is matrix_score(byte [0,0,1,1], [1,0,1,0], [1,1,0,0]), 39, 'example 1';
        is matrix_score(byte [[0]]), 1, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is matrix_score(byte [1, 1, 0, 0, 0, 1], [0, 0, 0, 1, 1, 1],
            [1, 0, 1, 1, 0, 0], [0, 1, 1, 0, 0, 1], [1, 0, 0, 0, 1, 1]),
            253, 'toggle all but first columns';
            # 32 * 5 + (16 + 8 + 4 + 2 + 1) * 3

	}

    done_testing;
    exit;
}
