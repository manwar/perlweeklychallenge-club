#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Math::Prime::Util 'todigits';

our ($tests, $examples, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=B] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    use B as base for the given numbers' representation. Default: 10

N...
    list of numbers

EOS


### Input and Output

main: {
    $" = ', ';
    say "(@{[separate_digits($base, @ARGV)]})"
}


### Implementation

# Concatenate the digits of each number in the given base.
sub separate_digits {
	my $base = shift;
    map todigits($_, $base), @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [separate_digits(10, 1, 34, 5, 6)], [1, 3, 4, 5, 6], 'example 1';
        is [separate_digits(10, 1, 24, 51, 60)], [1, 2, 4, 5, 1, 6, 0],
            'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is [separate_digits(2, 1, 3, 7)], [(1) x 6], 'binary';
	}

    done_testing;
    exit;
}
