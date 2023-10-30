#!/usr/bin/perl -s

use v5.25;
use Test2::V0;
use Math::Permutation;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    zero-based permutation of any size in one-line notation

EOS


### Input and Output

say cycles(@ARGV);


### Implementation

# As the given numbers shall be unique and at the same time be indices
# into an array of the same size, they actually represent a zero-based
# permutation in one-line notation.  This task asks for the number of
# cycles.  Transforming the numbers into a one-based one-line notation,
# creating a permutation thereof, converting to cycles and counting
# these with the help of CY's Math::Permutation module.

sub cycles {
    scalar Math::Permutation->wrepr([map $_ + 1, @_])->cyc->@*;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        is cycles(4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10),
            3, 'example 1';
        is cycles(0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19),
            6, 'example 2';
        is cycles(9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17),
            1, 'example 3';

    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
