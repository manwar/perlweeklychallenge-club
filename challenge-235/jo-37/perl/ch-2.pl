#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

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

say "(@{dup_zeroes(@ARGV)})";


### Implementation

# There's almost no need to comment this implementation as it literally
# follows the task: Count sequential occurrences of every number, double
# all zeroes' occurrences and trim the result to the original size.

sub dup_zeroes {
	my $n = long @_;
    my ($l, $v) = rle $n;
    $l->where($v == 0) *= 2;
    rld($l, $v)->reshape($n->dims)->unpdl;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        is dup_zeroes(1, 0, 2, 3, 0, 4, 5, 0),
            [1, 0, 0, 2, 3, 0, 0, 4], 'example 1';
        is dup_zeroes(1, 2, 3), [1, 2, 3], 'example 2';
        is dup_zeroes(0, 3, 0, 4, 5), [0, 0, 3, 0, 0], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
