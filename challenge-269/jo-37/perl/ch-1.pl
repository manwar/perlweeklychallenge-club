#!/usr/bin/perl -s

use v5.26;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

I...
    list of integers

EOS


### Input and Output

say +(qw(false true))[mtz(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/05/17/ch-269.html#task-1


sub mtz {
    1 < grep !($_ & 1), @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok mtz(1, 2, 3, 4, 5), 'example 1';
        ok mtz(2, 3, 8, 16), 'example 2';
        ok !mtz(1, 2, 5, 7, 9), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
