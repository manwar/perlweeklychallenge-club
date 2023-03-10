#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

WORD...
    filter given words for those consisting of letters from a single
    keyboard row only

EOS


### Input and Output

say for keyboard_words(@ARGV);


### Implementation

sub keyboard_words {
    # Match words against keyboard rows.
	grep /^(?i:[qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$/, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [keyboard_words(qw(Hello Alaska Dad Peace))],
            [qw(Alaska Dad)], 'example 1';
        is [keyboard_words(qw(OMG Bye))], [], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
