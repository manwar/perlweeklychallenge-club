#!/usr/bin/perl -s

use v5.16;
use integer;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    calculate integer square root of N

EOS


### Input and Output

say int_sqrt(shift);


### Implementation

# Following the formulae in
# https://en.wikipedia.org/wiki/Integer_square_root#Using_only_integer_division

sub int_sqrt ($n) {
    my $prev = $n;
    while () {
        my $next = ($prev + $n / $prev) / 2;
        return $prev if $next >= $prev;
        $prev = $next;
    }
}


### Examples and tests

use Math::Prime::Util ();

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is int_sqrt(10), 3, 'example 1';
        is int_sqrt(27), 5, 'example 2';
        is int_sqrt(85), 9, 'example 3';
        is int_sqrt(101), 10, 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $mpu_sqrtint = \&Math::Prime::Util::sqrtint;
        grep {
            int_sqrt($_) != $mpu_sqrtint->($_) and !fail "$_ failed";
        } 1 .. 1e5 or pass 'cross check';
	}

    done_testing;
    exit;
}
