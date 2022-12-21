#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'reduce';

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

say lmfe(@ARGV);


### Implementation

# The task can be solved with a single reduce pass where the reduction
# consists of an array ref of
# - the current minumum number
# - the maximum frequency
# - a hash ref to the frequency of all seen numbers
# We have a new maximum if the frequency of the current element is
# larger than the current maximum frequency or the frequencies are equal
# and the current element is smaller than the current minimum element.
# Filter the incoming list for even numbers and take the requested
# number from the reduction as result.
#
# Least most frequent even:
sub lmfe {
    (reduce {
            my $c = $a->[2]{$b}++;
            $c > $a->[1] || $c == $a->[1] && $b < $a->[0] ?
                [$b, $c, $a->[2]] : $a;
        } [-1, '-inf'], grep !($_ % 2), @_
    )->[0];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is lmfe(1, 1, 2, 6, 2), 2, 'Example 1';
        is lmfe(1, 3, 5, 7), -1, 'Example 2';
        is lmfe(6, 4, 4, 6, 1), 4, 'Example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is lmfe(2, 2, 4, 4, 2), 2, 'pass hash ref 1';
        is lmfe(4, 4, 2, 2, 4), 4, 'pass hash ref 2';
        is lmfe(-4, 4, -4, 4, -4), -4, 'negative number with highest freq';
        is lmfe(4, 4, 4, -4, -4, -4), -4, 'negative number is smaller';
	}

    done_testing;
    exit;
}
