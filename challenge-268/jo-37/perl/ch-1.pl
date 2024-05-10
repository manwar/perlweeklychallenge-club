#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [--] [ListX ListY]

-examples
    run the examples from the challenge
 
-tests
    run some tests

ListX ListY
    two lists of comma separated numbers

EOS


### Input and Output

say magic_number(map [split /,/], @ARGV) // 'no magic number';


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/05/10/ch-268.html#task-1


sub magic_number ($x, $y) {
	my ($min, $max) = minmax pdl($y)->qsort - pdl($x)->qsort;
    $min == $max ? $min : undef;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is magic_number([3, 7, 5], [9, 5, 7]), 2, 'example 1';
        is magic_number([1, 2, 1], [5, 4, 4]), 3, 'example 2';
        is magic_number([2], [5]), 3, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is magic_number([1, 2], [3, 5]), U(), 'no magic number';
        is magic_number([1, 2], [2, 1]), 0, 'same numbers';
        is magic_number([4, 3], [1, 2]), -2, 'negative magic number';
	}

    done_testing;
    exit;
}
