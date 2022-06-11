#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(vecsum vecprod todigits divisors);
use List::MoreUtils 'zip6';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    Check if N is a weird number.

EOS


### Input and Output

say 0 + !!is_weird(shift);


### Implementation

# Check if the given number is "weird".  There are two conditions that
# make a number non-weired: either the sum of its "proper" divisors does
# not exceed the number itself or there is a subset of its proper
# divisors that sum up to the number.  Here "proper" divisors are
# the divisors including one and excluding the number itself.
sub is_weird ($n) {
    # Get the "proper" divisors by omitting the number itself.
    my @divisors = splice @{[divisors $n]}, 0, -1;
    return if $n > vecsum @divisors;
    # Use the bits of the binary representation of a number as selectors
    # for the divisor subset.
    for my $set (2 .. 2 ** @divisors - 2) {
        return if $n == vecsum map vecprod(@$_),
            zip6 @divisors, @{[todigits $set, 2, @divisors]}
    }

    # Here we have a weird number.
    1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok !is_weird(12), 'example 1';
        ok is_weird(70), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok is_weird(14770), 'from Wikipedia';
	}

    done_testing;
    exit;
}
