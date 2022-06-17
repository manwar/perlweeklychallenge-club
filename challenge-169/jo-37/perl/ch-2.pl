#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(gcd factor_exp euler_phi);
use List::Util 'all'; # only "all"
use Coro::Generator;
use experimental 'signatures';

our ($tests, $examples, $strong);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-strong] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-strong
    limit the result to "Strong Achilles numbers"

N
    Print the first N (Strong) Achilles numbers.

EOS


### Input and Output

main: {
    my $achilles = gen_achilles($strong);
    say $achilles->() for 1 .. shift;
}


### Implementation

# Brute force scan for (Strong) Achilles numbers.
sub gen_achilles ($s) {
    generator {
        for (my $n = 1;; $n++) {
            yield $n if is_achilles($n, $s);
        }
    }
}

# Check if N is a (Strong) Achilles number.
sub is_achilles ($n, $s) {
    # Get the prime exponents of N.
    my @exp = map $_->[1], factor_exp $n;

    all {$_ > 1} @exp and gcd(@exp) == 1 and
        (!$s || is_achilles(euler_phi($n), 0));
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $achilles = gen_achilles(0);
        is [map $achilles->(), 1 .. 20], [72, 108,  200,  288,  392,
            432,  500,  648,  675,  800,  864, 968, 972, 1125, 1152,
            1323, 1352, 1372, 1568, 1800], 'task 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok is_achilles(108, 0), 'example 1 from Wiki';
        ok !is_achilles(360, 0), 'example 2 from Wiki';
        ok !is_achilles(784, 0), 'example 3 from Wiki';
        ok is_achilles(500, 1), 'example 4 from Wiki';

        my $strong_achilles = gen_achilles(1);
        is [map $strong_achilles->(), 1 .. 35], [500, 864, 1944, 2000,
            2592, 3456, 5000, 10125, 10368, 12348, 12500, 16875, 19652,
            19773, 30375, 31104, 32000, 33275, 37044, 40500, 49392,
            50000, 52488, 55296, 61731, 64827, 67500, 69984, 78608,
            80000, 81000, 83349, 84375, 93312, 108000],
            'A194085 - Strong Achilles numbers';
	}

    done_testing;
    exit;
}
