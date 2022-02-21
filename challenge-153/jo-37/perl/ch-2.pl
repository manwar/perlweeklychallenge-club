#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(factorial vecsum todigits vecnone);
use experimental 'signatures';

our ($tests, $examples, $verbose, $base);

$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    Check factorions in base B. Default: 10

N
    Check if N is a factorion in base B

EOS


### Input and Output

say 0 + factorion($ARGV[0], $base);


### Implementation

sub factorion($n, $base=10) {
    $n == vecsum map factorial($_), todigits $n, $base;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok factorion(145), 'example 1';
        ok !factorion(125), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok factorion(40585), 'one more from WolframAlpha';
        ok vecnone {factorion($_)} 146 .. 40584;
        ok factorion(25, 6), '25 = 41(6) = 4! + 1!';
        ok factorion(26, 6), '26 = 42(6) = 4! + 2!';
        ok factorion(49, 5), '49 = 144(5) = 1! + 4! + 4!';
	}

    done_testing;
    exit;
}
