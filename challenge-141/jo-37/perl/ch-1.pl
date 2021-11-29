#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util 'divisor_sum';
use Coro::Generator;
use experimental 'signatures';

our ($tests, $examples, $count);
$count ||= 8;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-count=C] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-count=C
    Take C as the number of divisors. Default: 8

N
    Find the first N numbers having exactly C divisors.

EOS


### Input and Output

main: {
    my $gen_num_div = gen_num_div($count);
    say $gen_num_div->() for 1 .. shift;
}


### Implementation

# Build a generator for numbers having exactly C divisors. Though this
# my be accomplished easily by just counting the divisors, the task
# itself seems to have very interesting aspects.  At first glance the
# sequences for prime numbers C seem to be the primes to the power of
# C - 1.  Sadly, I don't have time to investigate this in detail.

sub gen_num_div ($c) {
    generator {
        for (my $n = 1;; $n++) {
            yield $n if divisor_sum($n, 0) == $c;
        }
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is gen_num_div(8)->(), 24, 'example 1'

    }

    SKIP: {
        skip "tests" unless $tests;

        my $gen_num_div_8 = gen_num_div(8);
        $gen_num_div_8->() for 1 .. 50;
        is $gen_num_div_8->(), 318, 'see http://oeis.org/A030626';

        my $gen_num_div_6 = gen_num_div(6);
        $gen_num_div_6->() for 1 .. 51;
        is $gen_num_div_6->(), 412, 'see http://oeis.org/A030515';
	}

    done_testing;
    exit;
}
