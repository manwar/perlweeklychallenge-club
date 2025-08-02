#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'pairvalues';
use List::MoreUtils qw(frequency duplicates);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

N...
    list of numbers

EOS


### Input and Output

say 0 + uniq_occur(@ARGV);


### Implementation

sub uniq_occur {
    ! duplicates pairvalues frequency @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  uniq_occur(1,2,2,1,1,3),            'example 1';
        ok !uniq_occur(1,2,3),                  'example 2';
        ok  uniq_occur(-2,0,1,-2,1,1,0,1,-2,9), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
