#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [H...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

H...
    list of integers

EOS


### Input and Output

say complete_days(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/07/05/ch-276.html#task-1


sub complete_days {
    my $c = hist pdl(@_) % 24, -0.5, 23.5, 1;

    sum $c * ($c - 1) / 2;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is complete_days(12, 12, 30, 24, 24), 2, 'example 1';
        is complete_days(72, 48, 24, 5),      3, 'example 2';
        is complete_days(12, 18, 24),         0, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is complete_days(0, 1, 2, 12, 24, 25, 26, 37, 49, 50, 74, 98),
            14, 'pairs from parts of 2, 3 and 5 elements';
            
	}

    done_testing;
    exit;
}
