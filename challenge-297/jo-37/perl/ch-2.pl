#!/usr/bin/perl -s

use v5.12;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [P...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

P...
    permutation of numbers 1 .. N

EOS


### Input and Output

say semi_ordered(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/29/ch-297.html#task-2


sub semi_ordered {
    my (undef, undef, $min, $max) = minmaximum long @_;

    $min + $#_ - $max - ($max < $min);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is semi_ordered(2, 1, 4, 3), 2, 'example 1';
        is semi_ordered(2, 4, 1, 3), 3, 'example 2';
        is semi_ordered(1, 2, 3, 4, 5), 0, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is semi_ordered(2 .. 10, 1, 20, 11 .. 19), 18, 'in the middle';
        is semi_ordered(2 .. 10, 20, 1, 11 .. 19), 19, 'swapped';
    }

    done_testing;
    exit;
}
