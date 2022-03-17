#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(is_prime todigits vecsum);
use Coro::Generator;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    Print the first N pernicious numbers

EOS


### Input and Output

main: {
    my $pn = gen_pernicious_numbers();
    say $pn->() for 1 .. shift;
}


### Implementation

# Build a generator for pernicious numbers.
# This implementation is not optimal as we try all numbers and check
# their binary representation.  It might be more efficient to construct
# the numbers from a prime number of bits.
sub gen_pernicious_numbers {
    generator {
        for (my $n = 2;; $n++) {
            yield $n if is_prime vecsum todigits $n, 2;
        }
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $pn = gen_pernicious_numbers();
        is [map $pn->(), 1 .. 10], [3, 5, 6, 7, 9, 10, 11, 12, 13, 14],
            'task 1';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $pn = gen_pernicious_numbers();
        $pn->() for 1 .. 64;
        is $pn->(), 100, '#65 from OEIS A052294';
	}

    done_testing;
    exit;
}
