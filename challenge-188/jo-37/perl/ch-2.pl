#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [X y]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print the GCD along with the number of steps required to find it
    using the Euclidean algorithm.

X Y
    Positive numbers to be processed with the Euclidean algorithm.

EOS


### Input and Output

if ($verbose) {
    printf "gcd: %d, count: %d\n", euclidean(@ARGV[0, 1]);
} else {
    say scalar euclidean(@ARGV[0, 1]);
}


### Implementation
# Task description:
#     You are given two positive integers $x and $y.
#
#     Write a script to find out the number of operations needed to make
#     both ZERO. Each operation is made up either of the followings:
#
#     $x = $x - $y if $x >= $y
#
#     or
#
#     $y = $y - $x if $y >= $x (using the original value of $x)
# 
# I have an issue with the word "either" here.  In my naive
# interpretation it denotes an "exclusive or".  However, the results
# following this interpretation contradict the examples.  Looking
# closer: There are two branches where the second branch is not labeled
# "otherwise" but has its own condition that may be true together with
# the first branch's.  When both branches may be performed in a single
# operation (i.e are not exclusive), the note "using the original value
# of $x" suddenly starts making sense and the examples can be
# reproduced.  Thus following this differing interpretation.
# Furthermore, if $x == $y, then both will become zero with the next
# (questionable) operation.  No need to actually perform it, just
# increment the counter.
# This procedure is the Euclidean algorithm but with the number of steps
# as output instead of the GCD.  Returning the GCD in list context as
# the first value and the count as the second.

sub euclidean ($x, $y) {
    my $cnt = 1;
	while ($x != $y) {
        # Operate on references to the ordered pair of numbers.
        my ($u, $v) = $x > $y ? \($x, $y) : \($y, $x);
        $$u -= $$v;
        $cnt++;
    }

    ($x, $cnt);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is euclidean(5, 4), 5, 'Example 1';
        is euclidean(4, 6), 3, 'Example 2';
        is euclidean(2, 5), 4, 'Example 3';
        is euclidean(3, 1), 3, 'Example 4';
        is euclidean(7, 4), 5, 'Example 5';
    }

    SKIP: {
        skip "tests" unless $tests;

        is euclidean(3, 3), 1, 'Single (skipped) step';
        is [euclidean(77, 91)], [7, 8], 'gcd';
	}

    done_testing;
    exit;
}
