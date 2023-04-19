#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [LIST IND...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

LIST
    list of numbers separated by comma and or space

IND...
    indices into LIST forming a sublist that shall be sorted

EOS


### Input and Output

say "(@{sort_sublist([split /[, ]\s*/, shift], @ARGV)})";


### Implementation

sub sort_sublist ($list, @indices) {
    $list->@[@indices] = sort {$a <=> $b} $list->@[@indices];
    $list;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is sort_sublist([10, 4, 1, 8, 12, 3], 0, 2, 5),
            [1, 4, 3, 8, 12, 10], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
