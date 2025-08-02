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
    list of integers

EOS


### Input and Output

say unique_number(@ARGV) // 'no single unique number';


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/08/23/ch-283.html#task-1

sub unique_number {
    my ($sum, $cnt, %seen) = (0, 0);
    ($seen{$_}, $sum, $cnt) = exists $seen{$_} ?
        (0, $sum - $seen{$_} * $_, $cnt - $seen{$_}) :
        (1, $sum + $_, $cnt + 1) for @_;

    $cnt == 1 ? $sum : undef;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is unique_number(3, 3, 1), 1, 'example 1';
        is unique_number(3, 2, 4, 2, 4), 3, 'example 2';
        is unique_number(1), 1, 'example 3';
        is unique_number(4, 3, 1, 1, 1, 4), 3, 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is unique_number(1, 2, 3, 3), U(),
            'multiple unique values';
        is unique_number(1, 2, 3, 3, 2, 1), U(), 'no unique value';
        is unique_number(-2, -1, 0, -2 , 0), -1, 'negative';
	}

    done_testing;
    exit;
}
