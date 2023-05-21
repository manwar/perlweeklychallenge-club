#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [--] [M...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M...
    a matrix in any form accepted by the PDL string contructor, e.g.
    "[1 2 3][4 5 6]"

EOS


### Input and Output

say third_smallest(pdl "@ARGV");


### Implementation

# There is no need to sort the matrix.  Just pick the third smallest
# value's index and return the value.
sub third_smallest ($p) {
    minimum_n_ind $p->flat, my $min = zeroes indx, 3;
    $p->flat->($min(-1))->sclr;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is third_smallest(pdl([3, 1, 2], [5, 2, 4], [0, 1, 3])), 1,
        'example 1';
        
        is third_smallest(pdl([2, 1], [4, 5])), 4,
        'example 2';

        is third_smallest(pdl([1, 0, 3], [0, 0, 0], [1, 2, 1])), 0,
        'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
