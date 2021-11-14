#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util qw(pairfirst);
use List::MoreUtils qw(frequency);
use experimental qw(signatures);

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [num ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

num ...
    numbers

EOS


### Input and Output

say odd_number(@ARGV);


### Implementation

sub odd_number (@n) {
    (pairfirst {$b % 2} frequency @n)[0];
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is odd_number(2, 5, 4, 4, 5, 5, 2), 5, 'example 1';
        is odd_number(1, 2, 3, 4, 3, 2, 1, 4, 4), 4, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is odd_number(1, 1, 2, 2), U(), 'no odd number';
	}

    done_testing;
    exit;
}
