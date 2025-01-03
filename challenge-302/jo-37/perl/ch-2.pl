#!/usr/bin/perl -s

use v5.24;
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

say start_val(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/03/ch-302.html#task-2


sub start_val {
    1 - long(@_)->cumusumover->hclip(0)->min;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is start_val(-3, 2, -3, 4, 2), 5, 'example 1';
        is start_val(1, 2), 1, 'example 2';
        is start_val(1, -2, -3), 5, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
    }

    done_testing;
    exit;
}
