#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::MoreUtils 'reduce_0';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [ISBN]

-examples
    run the examples from the challenge
 
-tests
    run some tests

ISBN
    Check if the given string is a valid ISBN-13 code.

EOS


### Input and Output

say 0 + check_isbn13(shift);


### Implementation

# An ISBN-13 code already contains the check digit.  Returning the
# trailing digit would solve the task: If it was not the correct check
# digit, it would not have been an ISBN-13 code.
#
# Solving a slightly different task instead: Check if a given a string
# looks like a valid ISBN-13 code.
sub check_isbn13 ($isbn) {
    $isbn =~ m{
        # 4 nonempty elements plus check digit separated by hyphens
        ^\d+-\d+-\d+-\d+-\d\z
        (?(?{
            length != 17 ||     # not 13 digits and 4 separators
            # weighted digit sum not a multiple of 10
            (reduce_0 {$a + $b * (($_ % 2) * 2 + 1)} split /-*/) % 10;
        }) (*FAIL))     # not an ISBN code
    }x;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is check_isbn13('978-0-306-40615-7'), T(), 'example 1'
    }

    SKIP: {
        skip "tests" unless $tests;

        is check_isbn13('978-0-596-00027-1'), T(), 'my old "camel"';
        is check_isbn13('978-0-596-0000027-1'), F(), 'length';
        is check_isbn13('978-0-596-00027-2'), F(), 'check digit';
	}

    done_testing;
    exit;
}
