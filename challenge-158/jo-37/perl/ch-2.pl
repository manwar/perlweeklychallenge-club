#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Coro::Generator;
use Math::Prime::Util 'is_prime';
use Syntax::Keyword::Gather;
use experimental 'signatures';

our ($tests, $examples, $verbose, $series);
$series ||= 1;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-series=n] [LIM]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-series=n
    produce the n-th series of cuban primes. Default: 1

LIM
    Print the cuban primes less than given limit

EOS


### Input and Output

say for cuban_primes_below($series, shift);


### Implementation

# Calculating generalized series of cuban primes, controlled by
# parameter n.  The first and second series are produced by values 1 and
# 2 respectively.  Restricting to y > 0.
# The relation p = (x³ - y³) / (x - y), x = y + n can easily be
# transformed into
# p = 3 y² + 3 n y + n². 
# A simple calculation reveals
# p(y + 1) = p(y) + 3 (2 y + n + 1)
# which gives a nice iterative formula for p starting with y = 0
# and p = n².
sub cuban_primes_below ($n, $limit) {
    # There is no n-th series if n is a multiple of 3.
    die 'no such series' unless $n % 3;

    # Build a generator for cuban primes by checking if p is prime.
    my $cp_i = generator {
        my ($y, $p) = (0, $n ** 2);
        while () {
            $p += 3 * (2 * $y++ + $n + 1);
            yield $p if is_prime $p;
        }
    };

    # Collect cuban primes below the given limit.
    gather {
        my $cp;
        take $cp while ($cp = $cp_i->()) < $limit
    };
    # Déjà vu?
    # Déjà vu! 
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar cuban_primes_below(1, 1000),
        [7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919],
        'example 1';
    }

    SKIP: {
        skip "tests" unless $tests;

        is scalar cuban_primes_below(1, 26228),
        [7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919, 1657, 1801,
            1951, 2269, 2437, 2791, 3169, 3571, 4219, 4447, 5167, 5419,
            6211, 7057, 7351, 8269, 9241, 10267, 11719, 12097, 13267,
            13669, 16651, 19441, 19927, 22447, 23497, 24571, 25117,
            26227],
        'first series from Wikipedia';

        is scalar cuban_primes_below(2, 69314),
        [13, 109, 193, 433, 769, 1201, 1453, 2029, 3469, 3889, 4801,
            10093, 12289, 13873, 18253, 20173, 21169, 22189, 28813,
            37633, 43201, 47629, 60493, 63949, 65713, 69313],
        'second series from Wikipedia';


        is scalar cuban_primes_below(4, 4112),
        [31, 79, 151, 367, 1087, 1327, 1879, 2887, 3271, 4111],
        'fourth series, see http://oeis.org/A201477';
        # p = 7 corresponds to y = -1 and is thus missing here.
	}

    done_testing;
    exit;
}
