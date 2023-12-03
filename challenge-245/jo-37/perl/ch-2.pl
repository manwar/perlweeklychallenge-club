#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [D...]

-examples
    run the examples from the challenge

-tests
    run some tests

D...
    list of decimal digits

EOS


### Input and Output

say largest_of_three(@ARGV);


### Implementation

sub largest_of_three {
	my (@digits, @ind, $mod) = dsort(@_);
    for (0 .. $#digits) {
        # The digit modulo 3
        my $digit = $digits[$_] % 3;
        # Store indices of digits that are not a multiple of 3
        push $ind[$digit - 1]->@*, $_ if $digit;
        # Update the digit sum
        $mod += $digit;
    }
    $mod %= 3;
    # Delete the fewest smallest digits to obtain a digit sum divisible
    # by 3.
    delete @digits[
        !$mod-- ? () : $ind[$mod] ? $ind[$mod][0] : $ind[!$mod]->@[0, 1]
    ];

    # Build the maximum number from the remaining digits in descending
    # order or fail.
    @digits ? 0 + join '', reverse grep defined, @digits : -1;
}

sub dsort {
    my @digits;
    $digits[$_]++ for @_;
    map +($_) x ($digits[$_] // 0), 0 .. 9;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is largest_of_three(8, 1, 9), 981, 'example 1';;
        is largest_of_three(8, 6, 7, 1, 0), 8760, 'example 2';
        is largest_of_three(1), -1, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is largest_of_three(6, 4, 3), 63, 'single 1 mod 3';
        is largest_of_three(6, 5, 3), 63, 'single 2 mod 3';
        is largest_of_three(6, 4, 4, 3), 63, 'double 1 mod 3';
        is largest_of_three(6, 5, 5, 3), 63, 'double 2 mod 3';
        is largest_of_three(6, 3), 63, '0 mod 3';
        is largest_of_three(1, 1), -1, 'double 1';
        is largest_of_three(2, 2), -1, 'double 2';
        is largest_of_three(2), -1, 'like example 3';
        is largest_of_three(0, 0, 0, 1), 0, 'zero';
        is largest_of_three(6, 2, 2, 2, 7), 6222, 'remove the largest digit';
	}

    done_testing;
    exit;
}
