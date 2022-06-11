#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(prime_iterator is_prime vecsum todigits);
use Coro::Generator;
use Syntax::Keyword::Gather;
use experimental 'signatures';

our ($tests, $examples, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=B] [LIM]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    Use number representation in given base.

LIM
    Print additive primes below given limit.

EOS


### Input and Output

say for additive_primes_below(shift, $base);


### Implementation

sub additive_primes_below ($limit, $base = 10) {
    my $p_i = prime_iterator();

    # Build a generator for additive primes in the given base.
    my $ap_i = generator {
        my $p;
        while () {
            yield $p if is_prime vecsum todigits $p = $p_i->(), $base;
        }
    };

    # Collect all additive primes below the given limit.
    gather {
        my $ap;
        take $ap while ($ap = $ap_i->()) < $limit;
    };
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar additive_primes_below(100),
        [2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89],
        'task 1';
    }

    SKIP: {
        skip "tests" unless $tests;

        is scalar additive_primes_below(32, 2),
        [3, 5, 7, 11, 13, 17, 19, 31],
        'pernicious primes';
	}

    done_testing;
    exit;
}
