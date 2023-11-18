#!/usr/bin/perl -s

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
    list of positive integers

EOS


### Input and Output

say floor_sum(@ARGV);


### Implementation

# Sum over floor($nums[$i] / $nums[$j]).

sub floor_sum {
    my $nums = pdl @_;

    floor($nums / $nums->dummy(0))->sum;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is floor_sum(2, 5, 9), 10, 'example 1';
        is floor_sum(7, 7, 7, 7, 7, 7, 7), 49, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        # floor(3 / (-2)) = -2
        # floor((-2) / 3) = -1
        is floor_sum(3, -2), -1, 'negative elements';
	}

    done_testing;
    exit;
}
