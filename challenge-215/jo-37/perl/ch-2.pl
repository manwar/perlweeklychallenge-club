#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL v2.017;

our ($tests, $examples, $count);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV && $count;
usage: $0 [-examples] [-tests] [-count=C] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-count=C
    check if C zeroes may be flipped

N...
    list of zeroes and ones

EOS


### Input and Output

say 0 + ($count <= replace_count(@ARGV));


### Implementation

# For every two zeroes following a single leading zero, one zero may be
# flipped.  Count sequential zeros and sum over the number of zeroes
# that may be flipped. 
sub replace_count {
    my ($count, $val) = rle long @_;

    sum +($count->where($val == 0) - 1) / 2;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  replace_count([1,0,0,0,1], 1), 'example 1';
        ok  replace_count([1,0,0,0,0,0,0,0,1], 3), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok  replace_count([0,0,0,0,0,1,0,0,0,0,0], 4), 'two blocks of 5 zeroes';
	}

    done_testing;
    exit;
}
