#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use bigint;
use List::Gen;
use Math::Prime::Util 'divisor_sum';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    print the first N perfect numbers

EOS


### Input and Output

gen_perfect()->take(shift)->say;


### Implementation

# No need to consider odd perfect numbers as none is known yet.  Thus
# restricting to those generated from Mersenne primes.
# Build a generator for even perfect primes.
sub gen_perfect {
	<2..>->map(sub {2**($_ - 1) * (2**$_ - 1)})
        ->filter(sub {divisor_sum($_) == 2 * $_});
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gen_perfect()->take(5), [6, 28, 496, 8128, 33550336],
            'task 1 from OEIS';
    }

    SKIP: {
        skip "tests" unless $tests;

        is gen_perfect()->get(5), 8589869056, 'next from OEIS';
	}

    done_testing;
    exit;
}
