#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'max';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STRING...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STRING...
    strings to be centered

EOS


### Input and Output

say for center(@ARGV);


### Implementation

sub center {
    my $max = max map length, @_;
    map ' ' x (($max - length)/2) . $_, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [center("This", "is", "a test of the", "center function")],
        ["     This", "      is", " a test of the", "center function"],
        'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
