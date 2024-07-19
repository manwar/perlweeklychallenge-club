#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [STR CHR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

STR
    a string

CHR
    a character (or substring)

EOS


### Input and Output

say reverse_word(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/07/19/ch-278.html#task-2


sub reverse_word ($str, $char) {

	$str =~ s#(.*?\Q$char\E)#join '', sort split //, $1#er;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is reverse_word("challenge", "e"), "acehllnge", "example 1";
        is reverse_word("programming", "a"), "agoprrmming", "example 2";
        is reverse_word("champion", "b"), "champion", "example 3";
    }

    SKIP: {
        skip "tests" unless $tests;

        is reverse_word("keep", "k"), "keep", "match first";
	}

    done_testing;
    exit;
}
