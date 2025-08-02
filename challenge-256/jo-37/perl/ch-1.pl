#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [W...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

W...
    list of words

EOS


### Input and Output

say maximum_pairs(@ARGV);


### Implementation

sub maximum_pairs {
    (\my %words)->@{@_} = map scalar reverse, @_;

    delete @words{grep $_ eq $words{$_}, keys %words};
    (grep defined, @words{values %words}) / 2; 
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is maximum_pairs("ab", "de", "ed", "bc"), 1, 'example 1';
        is maximum_pairs("aa", "ba", "cd", "ed"), 0, 'example 2';
        is maximum_pairs("uv", "qp", "st", "vu", "mn", "pq"), 2, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
