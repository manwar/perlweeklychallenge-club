#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 1;
usage: $0 [-examples] [-tests] [K I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

K
    target value

I...
    list of numbers

EOS


### Input and Output

say t_idx(@ARGV);


### Implementation

sub t_idx {
	my $k = shift;

    which $k == pdl(@_)->qsort;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is t_idx(2 ,=> 1, 5, 3, 2, 4, 2)->unpdl, [1, 2], 'example 1';
        is t_idx(6 ,=> 1, 2, 3, 4, 5)->unpdl, [], 'example 2';
        is t_idx(4 ,=> 5, 3, 2, 4, 2, 1)->unpdl, [4], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
