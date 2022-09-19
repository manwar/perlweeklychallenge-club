#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    string to be examined

EOS


### Input and Output

say first_uniq(shift);


### Implementation

sub first_uniq ($str) {
    # Count each character's occurrences.
    my %cnt;
    $cnt{$_}++ for split //, $str;
    # Return the index of the first unique character.
    $cnt{substr $str, $_, 1} == 1 && return $_ for 0 .. length($str) - 1;
    # If there is no unique character in the string:
    -1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is first_uniq('Perl Weekly Challenge'), 0, 'example 1';
        is first_uniq('Long Live Perl'), 1, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is first_uniq('aa'), -1, 'no unique character';
        is first_uniq(''), -1, 'empty string';
        is first_uniq('aa0'), 2, 'find zero';
	}

    done_testing;
    exit;
}
