#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [M]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M
    matrix in any form accepted by the PDL constructor,
    e.g. "3,7,8;9,11,13;15,16,17"

EOS


### Input and Output

say lucky_number("@ARGV");


### Implementation

sub lucky_number {
    my $m = pdl @_;
    my $minmax = $m->xchg(0, 1)->maxover->minimum;
    $minmax == $m->minover->maximum ? $minmax : -1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is lucky_number(
        [ 3,  7,  8],
        [ 9, 11, 13],
        [15, 16, 17]), 15, 'example 1';

        is lucky_number(
        [ 1, 10,  4,  2],
        [ 9,  3,  8,  7],
        [15, 16, 17, 12]), 12, 'example 2';

        is lucky_number(
        [7 ,8],
        [1 ,2]), 7, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is lucky_number(
        [2, 7, 5],
        [6, 1, 8],
        [3, 9, 4]), -1, 'none';

        # not unique:
        is lucky_number(
        [2, 3, 3],
        [1, 2, 3],
        [1, 1, 2]), 2, 'only one three twos is lucky';
	}

    done_testing;
    exit;
}
