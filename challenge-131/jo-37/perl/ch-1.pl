#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'reduce';
use Data::Dump;
use experimental qw(signatures postderef);

our ($tests, $examples);

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
dd @{consecutive_arrays(@ARGV)};


### Implementation

sub consecutive_arrays($f, @a) {
    reduce {
        if ($b == $a->[-1][-1] + 1) {
            push $a->[-1]->@*, $b;
        } else {
            push @$a, [$b];
        }
        $a;
    } [[$f]], @a;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is consecutive_arrays(1, 2, 3, 6, 7, 8, 9),
            [[1, 2, 3], [6, 7, 8, 9]], 'example 1';
        is consecutive_arrays(11, 12, 14, 17, 18, 19),
            [[11, 12], [14], [17, 18, 19]], 'example 2';
        is consecutive_arrays(2, 4, 6, 8),
            [[2], [4], [6], [8]], 'example 3';
        is consecutive_arrays(1, 2, 3, 4, 5),
            [[1, 2, 3, 4, 5]], 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is consecutive_arrays(1),
            [[1]], 'single value';
	}

    done_testing;
    exit;
}
