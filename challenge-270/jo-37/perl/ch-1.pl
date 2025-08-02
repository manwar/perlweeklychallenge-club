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
    matrix in any form acceptedd by the PDL string constructor, e.g.
    '[ [1, 0, 0], [0, 0, 1], [1, 0, 0] ]'


EOS


### Input and Output

say count_special("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/05/24/ch-270.html#task-1


sub count_special {
	my $m = pdl @_;
    which($m * $m->sumover->dummy(0) * $m->xchg(0, 1)->sumover == 1)->nelem;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_special([
                [1, 0, 0],
                [0, 0, 1],
                [1, 0, 0],]), 1, 'example 1';
        is count_special([
                [1, 0, 0],
                [0, 1, 0],
                [0, 0, 1],]), 3, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
