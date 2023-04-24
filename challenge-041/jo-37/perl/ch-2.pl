#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Gen;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    print the first N Leonardo Numbers

EOS


### Input and Output

gen_leonardo()->say(shift);


### Implementation

sub gen_leonardo {
    # Iterator where the next element is the sum of the previous two
    # plus one, starting with (1, 1).
    <1, 1, * + * + 1 ...>;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gen_leonardo()->take(20),
            [1, 1, 3, 5, 9, 15, 25, 41, 67, 109, 177, 287, 465, 753,
                1219, 1973, 3193, 5167, 8361, 13529],
            'task 2 from OEIS A001595';
    }

    SKIP: {
        skip "tests" unless $tests;

        is gen_leonardo()->take(38),
            [1, 1, 3, 5, 9, 15, 25, 41, 67, 109, 177, 287, 465, 753,
                1219, 1973, 3193, 5167, 8361, 13529, 21891, 35421,
                57313, 92735, 150049, 242785, 392835, 635621, 1028457,
                1664079, 2692537, 4356617, 7049155, 11405773, 18454929,
                29860703, 48315633, 78176337],
            'first 38 from A001595';
	}

    done_testing;
    exit;
}
