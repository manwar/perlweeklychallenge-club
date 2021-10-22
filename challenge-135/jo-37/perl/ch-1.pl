#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    Number. Use '-- -N' for negative numbers.

EOS


### Input and Output

say middle_digits(shift);


### Implementation

sub middle_digits ($n) {
    $n = int abs $n;
    my $l = length $n;
    die "even number of digits\n" unless $l % 2;
    die "too short\n" unless $l >= 3;
    substr $n, ($l - 3) / 2, 3;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is middle_digits(1234567), 345, 'example 1';
        is middle_digits(-123), 123, 'example 2';
        like dies {middle_digits(1)}, qr(too short), 'example 3';
        like dies {middle_digits(12)}, qr(even number of digits), 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is middle_digits('0012345'), 234, 'ignore leading zeros';
        is middle_digits(12345.67), 234, 'force float to integer';
        is middle_digits(-12345.67), 234, 'force negative float to integer';
	}

    done_testing;
    exit;
}
