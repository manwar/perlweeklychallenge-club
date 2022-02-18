#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(vecmin vecsum);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [a11 a21,a22 ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

a11 a21,a22 ...
    elements of an AoA.  Arrays must not be empty but may have any size.

EOS


### Input and Output

say minsum([map [split /[ ,] */], @ARGV]);


### Implementation

# The triangular data shape might be a red herring suggesting to find
# some kind of path through the triangle.  However, from the examples I
# conclude it's just going through the whole array via any field in each
# row.  Thus the data's shape is completely irrelevant and is ignored
# here.

# Find the minumum sum picking one element from each row of an AoA.
sub minsum {
    vecsum map vecmin(@$_), @{+shift}
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is minsum([[1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8]]), 8,
            'example 1';
        is minsum([[5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9]]), 9,
            'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is minsum([[1, 2, 3], [1, 2, 3], [1, 2, 3]]), 3, 'square';
	}

    done_testing;
    exit;
}
