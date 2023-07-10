#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

{
    # Import the solution from week #221.
    package CH_221;

    # Without arguments, the called program will die with a usage
    # message.  Capture this message as success indicator.
    local @ARGV;
    do '../../../challenge-221/jo-37/perl/ch-1.pl';
    die $@ unless $@ =~ /^usage: $0/;
}

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [SOURCE TARGET]

-examples
    run the examples from the challenge
 
-tests
    run some tests

SOURCE
    source string

TARGET
    check if the target can be created from the characters of SOURCE

EOS


### Input and Output

say CH_221::good_string_length(@ARGV) ? 'true' : 'false';


### Implementation

# This task is a special case of task 1 from week 221.  There's a single
# word to check and here we just need to see if the result is nonzero.


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok !CH_221::good_string_length('abc', 'xyz'), 'example 1';
        ok  CH_221::good_string_length('scriptinglanguage', 'perl'),
            'example 2';
        ok  CH_221::good_string_length('aabbcc', 'abc'), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
