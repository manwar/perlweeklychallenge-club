#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use Math::Prime::Util 'todigits';

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

say hamming_distance_sum(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/03/ch-301.html#task-2


sub hamming_distance_sum {
    my $b = long [map [reverse todigits $_, 2], @_];
    my $c = $b->xchg(0, 1)->sumover;

    sum $c * ($b->dim(1) - $c);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is hamming_distance_sum(4, 14, 2), 6, 'example 1';
        is hamming_distance_sum(4, 14, 4), 4, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
    }

    done_testing;
    exit;
}
