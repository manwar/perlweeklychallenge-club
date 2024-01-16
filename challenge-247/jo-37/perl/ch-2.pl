#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::Char;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [S]

-examples
    run the examples from the challenge
 
-tests
    run some tests

S
    string of lower case ascii characters

EOS


### Input and Output

say most_frequent_pair(shift);


### Implementation

sub most_frequent_pair {
	my $s = PDL::Char->new(shift);
    my ($count, $pairs) = rlevec($s->lags(0, 1, $s->dim(0) - 1)->qsortvec);
    $pairs->atstr($count->long->maximum_ind);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is most_frequent_pair('abcdbca'), 'bc', 'example 1';
        is most_frequent_pair('cdeabeabfcdfabgcd'), 'ab', 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
