#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Gen;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    print N's Collatz sequence

EOS


### Input and Output

# Append the final "one".
(gen_collatz(shift) + [1])->say;


### Implementation

sub gen_collatz ($n) {
    # Generator for N's Collatz sequence.
    iterate {$_ % 2 ? $_ * 3 + 1 : $_ / 2}->from($n)->until('== 1');
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gen_collatz(23)->apply, [23, 70, 35, 106, 53, 160, 80, 40,
            20, 10, 5, 16, 8, 4, 2], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
