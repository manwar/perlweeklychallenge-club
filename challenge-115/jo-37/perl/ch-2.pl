#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::MoreUtils 'lastidx';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [d...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

d...
    Digits to build the largest even number from.

EOS


### Input and Output

say largest_even(@ARGV);


### Implementation

sub largest_even {
    # Sort digits descending.
    my @d = sort {$b <=> $a} @_;

    # Some zeros don't make a number.
    return if $#d && !$d[0];

    # Get the index of the smallest even digit.
    my $sei = lastidx {!($_ % 2)} @d;

    # Give up if none found.
	return if $sei < 0;

    # Reorder the digits to form the largest even number.
    join '', @d[0 .. $sei - 1, $sei + 1 .. $#d, $sei];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is largest_even(1, 0, 2, 6), 6210, 'example 1';
        is largest_even(1, 4, 2, 8), 8412, 'example 2';
        is largest_even(4, 1, 7, 6), 7614, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is largest_even(1, 3, 5, 7), U(), 'no even digit';
        is largest_even(0, 0), U(), 'multiple zeros only';
        is largest_even(0), 0, 'single zero';
	}

    done_testing;
    exit;
}
