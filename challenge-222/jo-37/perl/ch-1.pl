#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say matching_members(@ARGV);


### Implementation

# Count the elements that are equal to the element at the same position
# in the sorted list.
sub matching_members {
	my $l = long @_;
    which($l == $l->qsort)->nelem;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is matching_members(1, 1, 4, 2, 1, 3), 3, 'example 1';
        is matching_members(5, 1, 2, 3, 4), 0, 'example 2';
        is matching_members(1, 2, 3, 4, 5), 5, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
