#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say maximum_number(@ARGV);


### Implementation

# At first glance it looks as the reverse lexicographic order would
# solve the task, but this is disproved by example 5.  Thus creating a
# "reverse concatenation order".
sub maximum_number {
    join '', sort {$b . $a <=> $a . $b} @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is maximum_number(1, 23), 231, 'example 1';
        is maximum_number(10, 3, 2), 3210, 'example 2';
        is maximum_number(31, 2, 4, 10), 431210, 'example 3';
        is maximum_number(5, 11, 4, 1, 2), 542111, 'example 4';
        is maximum_number(1, 10), 110, 'example 5';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
