#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::MoreUtils qw(part);
use List::UtilsBy qw(zip_by);
use Data::Dump;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STRING...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STRING...
    list of strings, where each string consists of space-separated
    digits and letters

EOS


### Input and Output

dd split_array(@ARGV);


### Implementation

# Split each string into its space separated elements, distribute these
# onto two buckets of non-digits and digits, collect alike buckets and
# drop empty ones.
sub split_array {
    [map {[grep $_, @$_]}
        zip_by {[@_]}
        map {[part {/\D/} @$_]}
        map [split], @_];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is split_array('a 1 2 b 0', '3 c 4 d'),
            [[[1,2,0], [3,4]], [['a','b'], ['c','d']]], 'example 1';
        is split_array('1 2', 'p q r', 's 3', '4 5 t'),
            [[[1,2], [3], [4,5]], [['p','q','r'], ['s'], ['t']]], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
