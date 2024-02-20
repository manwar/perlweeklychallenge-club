#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [S T]

-examples
    run the examples from the challenge
 
-tests
    run some tests

S T
    two strings

EOS


### Input and Output

say merge_strings(@ARGV);


### Implementation

sub merge_strings ($s, $t) {
    my $zip;
	while ($s || $t) {
        $zip .= ($s && substr($s, 0, 1, '')) . ($t && substr($t, 0, 1, ''));
    }
    $zip;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is merge_strings('abcd', '1234'), 'a1b2c3d4', 'example 1';
        is merge_strings('abc', '12345'), 'a1b2c345', 'example 2';
        is merge_strings('abcde', '123'), 'a1b2c3de', 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
