#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
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
    Check if the square root of N is the sum of two or more splits of N

EOS


### Input and Output

say 0 + root_sum(shift);


### Implementation

sub root_sum ($n) {
    # Split N into at least two parts and compare the squared sum of the
    # parts with N.
    # There is no need to disallow leading zeros in any part (except the
    # first), as these may be split-off as separate parts resulting in
    # the same sum and a larger number of parts, e.g.
    # 201: 2 + 01 or 2 + 0 + 1.
    # The only exception are single digit numbers that cannot be split
    # into two parts and therefore must not have leading zeros.
    our $sum;
    $n =~ m{
        ^
        (?=\d+$)    # Numbers only.
        (?!0+.$)    # Forbid leading zeros for 1-digit numbers.
        (?{local $sum = 0})   # Initialize and localize the part sum.
        (?:
            (.+)    # capture one part
            (?{local $sum = $sum + $^N})    # backtracking-safe part sum
        ){2,}       # two or more parts
        $

        # Check part sum for complete matches:
        (?(?{$sum ** 2 != $n}) (*FAIL))
    }x;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is root_sum(81),    T(), 'example 1';
        is root_sum(9801),  T(), 'example 2';
        is root_sum(36),    F(), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is root_sum(1296),  T(), 'without zeros';
        is root_sum(18),    F(), 'not a square';
        is root_sum(0),     F(), 'zero';
        is root_sum('00'),  F(), 'double zero';
        is root_sum(1),     F(), 'one';
        is root_sum('01'),  F(), 'one with leading zero';
        is root_sum('001'), F(), 'one with leading zeros';
        is root_sum('081'), T(), 'leading zero';
        is root_sum(-abc),  F(), 'non-numeric';
	}

    done_testing;
    exit;
}
