#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say "(@{[move_zero(@ARGV)]})";


### Implementation

sub move_zero {
    my $cnt;
    # Count and suppress zeroes, then append the suppressed zeroes.
    ((grep {$cnt += !$_; $_} @_), (0) x $cnt)
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [move_zero(1, 0, 3, 0, 0, 5)], [1, 3, 5, 0, 0, 0], 'example 1';
        is [move_zero(1, 6, 4)], [1, 6, 4], 'example 2';
        is [move_zero(0, 1, 0, 2, 0)], [1, 2, 0, 0, 0], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [move_zero(0, 0, 0)], [0, 0, 0], 'zeroes only';
        is [move_zero(1, 0, -1)], [1, -1, 0], 'negative';
	}

    done_testing;
    exit;
}
