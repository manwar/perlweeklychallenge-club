#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [M]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M
    a matrix in any form accepted by the PDL string constructor,
    e.g.
    "[[1, 2, 0, 0, 4], [1, 1, 1, 1, 0], [3, 0, 0, 0, 0]]"
EOS


### Input and Output

say weakest("@ARGV");


### Implementation

sub weakest {
	my $m = pdl @_;
    $m->append($m((0))->ndcoords)->qsortveci;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is weakest([
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 0],
                   [1, 0, 0, 0, 0],
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 1]
                 ])->unpdl, [2, 0, 3, 1, 4], 'example 1';

        is weakest([
                   [1, 0, 0, 0],
                   [1, 1, 1, 1],
                   [1, 0, 0, 0],
                   [1, 0, 0, 0]
                 ])->unpdl, [0, 2, 3, 1], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is weakest([0, 1, 2, 3],
                   [1, 0, 0, 0],
                   [1, 2, 3, 4],
                   [0, 1, 2, 3],
                   [1, 2, 3, 5])->unpdl, [0, 3, 1, 2, 4], 'arbitrary matrix';
	}

    done_testing;
    exit;
}
