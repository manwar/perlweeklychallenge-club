#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

N...
    list of numbers

EOS


### Input and Output

say solve_task();


### Implementation

# Select the run lengths of odd number and check for at least three.
sub consecutive_odds {
    my ($rl, $mod) = rle long(@_) % 2;
    any where($rl, $mod) >= 3;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  consecutive_odds(1, 3, 5, 6), 'example 1';
        ok !consecutive_odds(2, 6, 3, 5), 'example 2';
        ok !consecutive_odds(1, 2, 3, 4), 'example 3';
        ok  consecutive_odds(2, 3, 5, 7), 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok !consecutive_odds(2, 4, 6), 'do not count even numbers';
	}

    done_testing;
    exit;
}
