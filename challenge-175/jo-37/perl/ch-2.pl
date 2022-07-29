#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(euler_phi);
use List::Gen qw(:iterate :while);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    Print the first N perfect totient numbers.

EOS


### Input and Output

perfect_totient()->say(shift);


### Implementation

# Another exercise in using List::Gen.

sub perfect_totient {
    # Build a generator for perfect totient numbers.  Here we use two
    # nested generators to accomplish the task.

    # Build a non-caching generator for odd numbers N starting with 3
    # and filter for perfect totient numbers. 
    iterate_stream {$_ + 2}->from(3)->filter_stream(sub {
        # Build a generator for the iterative sequence of totients for N
        # and sum over the sequence's elements.  The generated sequence
        # will start with N because of "from($_)" and will not include 1
        # according to the chained "until" method.  Therefore the
        # expected sum needs to be adjusted: There is an extra "N" and 1
        # is missing. Thus we expect a sum of 2 * N - 1 for a perfect
        # totient number.
        iterate {euler_phi($_)}->from($_)->until('== 1')->sum == 2 * $_ - 1;
    });
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is perfect_totient()->take(20), [3, 9, 15, 27, 39, 81, 111, 183,
            243, 255, 327, 363, 471, 729, 2187, 2199, 3063, 4359, 4375,
            5571], 'task 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is perfect_totient()->(25), 46791, 'from A082897';
	}

    done_testing;
    exit;
}
