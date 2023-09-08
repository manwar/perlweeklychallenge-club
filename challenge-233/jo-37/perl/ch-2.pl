#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

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

say "(@{frequency_sort(@ARGV)})";


### Implementation

# Sort the numbers, run length encode them, create a single piddle from
# the run lengths and values, pair run lengths and values, invert the
# values for descending sort, lexically sort the pairs, re-invert the
# values, separate run lengths and values into separate piddles and run
# length decode them.
sub frequency_sort {
    state $inv = long 1, -1;
    rld(
        cat(long(@_)->qsort->rle)
        ->xchg(0, 1)->mult($inv, 0)->qsortvec->mult($inv, 0)->xchg(0, 1)
        ->dog
    )->unpdl;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is frequency_sort(1,1,2,2,2,3), [3,1,1,2,2,2], 'example 1';
        is frequency_sort(2,3,1,3,2), [1,3,3,2,2], 'example 2';
        is frequency_sort(-1,1,-6,4,5,-6,1,4,1), [5,-1,4,4,-6,-6,1,1,1], 
            'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
