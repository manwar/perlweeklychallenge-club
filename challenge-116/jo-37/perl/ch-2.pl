#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(vecsum is_square);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [num]

-examples
    run the examples from the challenge
 
-tests
    run some tests

num
    check if the sum of the squared decimal digits of num is a perfect square

EOS


### Input and Output

say 0 + sum_of_squares_is_square(shift);


### Implementation

sub sum_of_squares_is_square {
    local $_ = shift;
    # Input is restricted to N >= 10:
    die "not valid\n" unless /^[1-9][0-9]+\z/;

    # The digits are subject to integer operations only, therefore there
    # are no rounding issues.  Takes a string, not an (internal)
    # integer.
    is_square vecsum map $_ * $_, split //;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        ok sum_of_squares_is_square(34), 'example 1';
        ok sum_of_squares_is_square(50), 'example 2';
        ok !sum_of_squares_is_square(52), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
        ok sum_of_squares_is_square(10), 'smallest number for given limit';
        ok sum_of_squares_is_square(236), 'three nonzero digits';
        ok sum_of_squares_is_square('1' x 196), '1**2 * 196 == 14**2';
        ok sum_of_squares_is_square('9' x 81), '9**2 * 81 == 81**2';
	}

    done_testing;
    exit;
}
