#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util 'todigits';
use experimental qw(signatures postderef);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    Check if N is a Brazilian number.  Prints the smallest base where N
    is Brazilian or zero otherwise.

EOS


### Input and Output

say is_brazilian(shift);


### Implementation

# Take the "digits" of N as keys in a hash and check if there is only
# one such key.  Returns the smallest base found or zero otherwise.
sub is_brazilian ($n) {
    for my $b (2 .. $n - 2) {
        (\my %digits)->@{todigits $n, $b} = ();
        return $b if 1 ==  keys %digits;
    }
    return 0;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is is_brazilian(7), 2, 'example 1';
        is is_brazilian(6), F(), 'example 2';
        is is_brazilian(8), 3, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is is_brazilian(13330), 36, 'aaa(36)';
        is is_brazilian(54871), 38, 'brazilian beyond base 36';
        is is_brazilian(1299709), F(), '100000th prime';
	}

    done_testing;
    exit;
}
