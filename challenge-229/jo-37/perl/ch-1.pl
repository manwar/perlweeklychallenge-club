#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::MoreUtils qw(slide minmax);

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

WORD...
    list of words

EOS


### Input and Output

say $verbose ? join ' ', unordered(@ARGV) : scalar unordered(@ARGV);


### Implementation

# Pairwise compare the characters of each word and collect the results.
# A lexicographical ordered word has a maximum-minimum difference of
# zero or one and an unordered word a difference of two.
# Returns the to-be-deleted words in list context and their count in
# scalar context.
sub unordered {
	grep {
        my ($min, $max) = minmax slide {$a cmp $b} split //, $_;
        $max - $min > 1;
    } @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar(unordered("abc", "bce", "cae")), 1, 'example 1';
        is scalar(unordered("yxz", "cba", "mon")), 2, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [unordered(qw(abbc abba aaaa))], ['abba'], 'same chars are ordered';
	}

    done_testing;
    exit;
}
