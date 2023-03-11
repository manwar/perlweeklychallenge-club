#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    calculate the H-Index for the given numbers

EOS


### Input and Output

say hirsch(@ARGV);


### Implementation

sub hirsch {
    # Compare the reverse-sorted list's elements with their index
    # position and pick the largest index where the difference is
    # positive.  Finally adjust the zero-based array index to the
    # one-based H-Index.
    which(pdl(@_)->qsort->(-1:0) > sequence(scalar @_))->((-1)) + 1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is hirsch(10, 8, 5, 4, 3), 4, 'example 1';
        is hirsch(25, 8, 5, 3, 3), 3, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is hirsch(9, 7, 6, 2, 1), 3, 'from Wikipedia';
        is hirsch(1, 7, 6, 2, 9), 3, 'same, not sorted';
        is hirsch(5, 5, 5, 5, 5), 5, 'last index';
	}

    done_testing;
    exit;
}
