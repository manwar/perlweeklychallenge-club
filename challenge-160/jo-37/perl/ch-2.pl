#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'sum0';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [I1 I2 ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

I1 I2 ...
    List of integers.

EOS


### Input and Output

say equilibrium_index(@ARGV);


### Implementation

# The task does not specify if empty subarrays are allowed.  Assuming
# they are allowed and have a sum of zero.
sub equilibrium_index {
    my ($i, $left, $right) = (0, 0, sum0 @_[1 .. $#_]);
    # Starting with an empty left subarray, shift the index until an
    # equilibrium is found or the right subarray becomes empty.
    while ($left != $right && $i < $#_) {
        $left += $_[$i++];
        $right -= $_[$i];
    }

    $left == $right ? $i : -1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is equilibrium_index(1, 3, 5, 7, 9), 3, 'example 1';
        is equilibrium_index(1, 2, 3, 4, 5), -1, 'example 2';
        is equilibrium_index(2, 4, 2), 1, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is equilibrium_index(1, 1, 1, 3, -1), 2, 'negative element';
        is equilibrium_index(1, -1, 2), 2, 'empty right subarray';
        is equilibrium_index(2, 1, -1), 0, 'empty left subarray';
        is equilibrium_index(1), 0, 'two empty subarrays';
	}

    done_testing;
    exit;
}
