#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental qw(signatures postderef);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [TIME]

-examples
    run the examples from the challenge
 
-tests
    run some tests

TIME
    incomplete time string containing one question mark at a digit position.

EOS


### Input and Output

say missing(shift);


### Implementation

sub missing ($t) {
    # For each position of the question mark define a list of
    # regex-value pairs that provide the maximum value that may replace
    # the question mark if the regex matches.
    state $match = [
        [[qr/^.[4-9]/, 1], [qr//, 2]],
        [[qr/^2/, 3], [qr//, 9]],
        undef,
        [[qr//, 5]],
        [[qr//, 9]]];

    # Apply the patterns in the list for the question mark's position
    # and return the respective value for a match.
    $t =~ $_->[0] && return $_->[1] for $match->[index($t, '?')]->@*;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is missing('?5:00'), 1, 'example 1';
        is missing('?3:00'), 2, 'example 2';
        is missing('1?:00'), 9, 'example 3';
        is missing('2?:00'), 3, 'example 4';
        is missing('12:?5'), 5, 'example 5';
        is missing('12:5?'), 9, 'example 6';

    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
