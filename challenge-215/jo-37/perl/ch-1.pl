#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::Char;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

WORD...
    list of words

EOS


### Input and Output

say count_unsorted(@ARGV);


### Implementation

# Compare each word with its sorted bytes, find any divergences and
# count the concerned words.

sub count_unsorted {
    my $w = PDL::Char->new(@_);

    which(($w <=> $w->qsort)->orover)->dim(0);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_unsorted('abc', 'xyz', 'tsu'), 1, 'example 1';
        is count_unsorted('rat', 'cab', 'dad'), 3, 'example 2';
        is count_unsorted('x', 'y', 'z'), 0, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
