#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Math::Prime::Util 'todigits';

our ($tests, $examples, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=BASE] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

-base=BASE
    regard numbers in base BASE. Default: 10

N...
    list of numbers

EOS


### Input and Output

say cedn($base, @ARGV);


### Implementation

sub cedn {
    my $base = shift;
	scalar grep !(scalar(todigits($_, $base)) % 2), @_
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is cedn(10 => 10, 1, 111, 24, 1000), 3, 'example 1';
        is cedn(10 => 111, 1, 11111), 0, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
