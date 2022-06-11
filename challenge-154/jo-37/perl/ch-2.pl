#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use bigint;
use Math::Prime::Util 'is_prime';
use Coro::Generator;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    print the first N Padovan prime numbers

EOS


### Input and Output

main: {
    my $padovan_primes = gen_padovan_primes();
    say $padovan_primes->() for 1 .. shift;
}


### Implementation

# Some considerations about the uniqueness of Padovan numbers:
# Suppose the last three numbers (p1, p2, p3) at a certain point in the
# sequence fulfill the inequalities
# 0 < p1 < p2 < p3
# p1 + p2 > p3
# Then the next step leads to the triple
# (q1, q2, q3) = (p2, p3, p1 + p2)
# and we have
# q1 = p2 > p1 > 0, i.e. q1 > 0
# q2 = p3 > p2 = q1, i.e. q2 > q1
# q3 = p1 + p2 > p3 = q2, i.e q3 > q2
# q3 = p1 + p2 < 2 * p2 = 2 * q1 < q1 + q2, i.e. q3 < q1 + q2.
# Taking the starting point (2, 3, 4), by induction we may conclude that
# the remaining Padovan numbers form a strictly monotonic sequence.
# After eliminating the duplicate number 2 there is no need to check for
# uniqueness any longer.

sub gen_padovan_primes {
    # Choose the starting point such that '2' appears only once.
    my ($p1, $p2, $p3) = (1, 1, 2);

    generator {
        while () {
            ($p1, $p2, $p3) = ($p2, $p3, $p1 + $p2);
            yield $p3 if is_prime $p3;
        }
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $padovan_primes = gen_padovan_primes();

        is [map $padovan_primes->(), 1 .. 10],
            [qw(2 3 5 7 37 151 3329 23833 13091204281 3093215881333057)],
            'task 1';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $padovan_primes = gen_padovan_primes();
        $padovan_primes->() for 1 .. 10;
        is $padovan_primes->(),
        1363005552434666078217421284621279933627102780881053358473,
        '#11 from OEIS';

        is $padovan_primes->(),
        1558877695141608507751098941899265975115403618621811951868598809164180630185566719,
        '#12 from OEIS';

        is length($padovan_primes->()), (154)->numify,
        'length of #13 from OEIS';
	}

    done_testing;
    exit;
}
