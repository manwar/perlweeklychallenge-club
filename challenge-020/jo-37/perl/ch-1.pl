#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    String to be split into groups of repeated characters

EOS


### Input and Output

say for @{split_string(shift)};


### Implementation

sub split_string {
    # Capture each repeated single character. There are two capture
    # groups in this regex: one captures the character and the other the
    # repeated character. Using embedded code to collect the repeated
    # chars.
    my @split;
    shift =~ /(((.)\g{-1}*)(?{push @split, $^N}))*/;
    \@split;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is split_string('ABBCDEEF'),
        [qw(A BB C D EE F)], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
