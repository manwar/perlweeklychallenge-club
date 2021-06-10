#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util qw(min max);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [num...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

num...
    numbers to examine

EOS


### Input and Output

say max_gap(@ARGV);


### Implementation

# Regardless of the sorting algorithm in use, every pair of neighboring
# elements must be compared in the process.  Otherwise the succession of
# such pair would remain undetermined.  Finding the gaps as mimimum
# differences while comparing and taking the maximum thereof afterwards.
sub max_gap {
	my %gap;
    # Discard the sort result.
    () = sort {
        my ($l, $h) = $a < $b ? ($a, $b) : ($b, $a);
        # Considering different values only.
        $gap{$l} = min $h - $l,  ($gap{$l} // 'inf') if $h > $l;
        $a <=> $b} @_;

    (max values %gap) // 0;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is max_gap(2, 9, 3, 5), 4, 'example 1';
        is max_gap(1, 3, 8, 2, 0), 5, 'example 2';
        is max_gap(5), 0, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
        is max_gap(1, -1, -2, -3, 3, 2, 1, -1), 2, 'non-unique values';
        is max_gap(0, 0, 0), 0, 'constant value';
        is max_gap(2, 5), 3, 'pair';
	}

    done_testing;
    exit;
}
