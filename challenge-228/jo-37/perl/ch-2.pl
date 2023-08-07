#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

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

say zero_array(@ARGV);


### Implementation

sub zero_array {
    my @sort = sort {$a <=> $b} @_;
    my ($head, $count);
    while (@_) {
        ($head = shift) == $sort[0] ? shift @sort : push @_, $head;
        $count++;
    }
    $count;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is zero_array(3, 4, 2), 5, 'example 1';
        is zero_array(1, 2, 3), 3, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
