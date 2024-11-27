#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [D...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

D...
    list of dominoes in the form A,B

EOS


### Input and Output

say count_similar(map [split /,/, $_], @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/08/ch-293.html#task-1


sub count_similar {
    my ($c) = long(@_)->qsort->qsortvec->rlevec;

    $c->where($c > 1)->sum;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_similar([1, 3], [3, 1], [2, 4], [6, 8]), 2, 'example 1';
        is count_similar([1, 2], [2, 1], [1, 1], [1, 2], [2, 2]), 3, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
    }

    done_testing;
    exit;
}
