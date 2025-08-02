#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'reduce';


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

say product_sign(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/05/03/ch-267.html#task-1


sub product_sign {
    eval {reduce {($b || die) < 0 ? -$a : $a} 1, @_} // 0;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is product_sign(-1, -2, -3, -4, 3, 2, 1),  1, 'example 1';
        is product_sign(1, 2, 0, -2, -1),          0, 'example 2';
        is product_sign(-1, -1, 1, -1, 2),        -1, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is product_sign( 10, (-10) x (1e6 - 1)), -1, 'large negative product';
        is product_sign(  0, (-10) x (1e6 - 1)),  0, 'zero product';
        is product_sign(-10, (-10) x (1e6 - 1)),  1, 'large positive product';

	}

    done_testing;
    exit;
}
