#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use warnings FATAL => 'all';
use Math::Prime::Util qw(vecreduce vecsum todigits);
use Data::Dump qw(dd pp);
use experimental 'signatures';

our ($tests, $examples, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=BASE] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=BASE
    use BASE for number representation. Default: 10

N...
    list of numbers

EOS


### Input and Output

say eds($base, @ARGV);


### Implementation

sub eds ($base, @ints) {
	vecreduce {$a + $b - vecsum todigits $b, $base} 0, @ints;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is eds(10 ,=> 1, 2, 3, 45), 36, 'example 1';
        is eds(10 ,=> 1, 12, 3), 9, 'example 2';
        is eds(10 ,=> 1, 2, 3, 4), 0, 'example 3';
        is eds(10 ,=> 236, 416, 336, 350), 1296, 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is eds(2 ,=> 3, 4), 4, '0b11, 0b100';
	}

    done_testing;
    exit;
}
