#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [--] [ARR1 ARR2]

-examples
    run the examples from the challenge
 
-tests
    run some tests

ARR1 ARR2
    two comma separated lists of integers

EOS


### Input and Output

say "(@{[missing_members(map [split /,/, $_], @ARGV)]})";


### Implementation

# Convert input arrays to unique, sorted piddles and build both set
# differences.  Return the two difference sets as piddles in list
# context or a ref to an AoA in scalar context. 

sub missing_members {
    my @a = map long($_)->uniq, @_;
    my @diff = map scalar setdiff_sorted($a[$_], $a[!$_]), 0, 1;
    wantarray ? @diff : [map $_->unpdl, @diff];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar missing_members([1, 2, 3], [2, 4, 6]),
            [[1, 3], [4, 6]], 'example 1';
        is scalar missing_members([1, 2, 3, 3], [1, 1, 2, 2]),
            [[3], []], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
