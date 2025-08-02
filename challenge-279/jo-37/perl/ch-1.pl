#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [LETTERS WEIGHTS]

-examples
    run the examples from the challenge
 
-tests
    run some tests

LETTERS
    list of letters, optionally separated by commas

WEIGHTS
    list of weights, optionally separated by commas

EOS


### Input and Output

say sort_letters(map [split /,*/, $_], @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/07/26/ch-279.html#task-1


sub sort_letters ($letters, $weights) {
    (\my @word)->@[map $_ - 1, @$weights] = @$letters;
    join '', @word;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is sort_letters(['R', 'E', 'P', 'L'], [3, 2, 1, 4]),
        'PERL', 'example 1';

        is sort_letters(['A', 'U', 'R', 'K'], [2, 4, 1, 3]),
        'RAKU', 'example 2';

        is sort_letters(['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]),
        'PYTHON', 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
