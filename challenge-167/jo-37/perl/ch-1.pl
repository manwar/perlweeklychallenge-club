#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(prime_iterator fromdigits todigits is_prime);
use Coro::Generator;
use experimental 'signatures';

our ($tests, $examples, $base, $minlen);

$base ||= 10;
$minlen ||= 3;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=B] [-minlen=L] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    Find circular primes in base B. Default: 10

-minlen=L
    Limit to circular primes having a minimum length of L (in base B)
    Default: 3

N
    Print the first N circular primes in base B.

EOS


### Input and Output

main: {
    my $cpg = gen_circular_primes($base, $minlen);
    say $cpg->() for 1 .. shift;
}


### Implementation

sub gen_circular_primes ($base, $minlen) {
    generator {
        my $it = prime_iterator;
        my %seen;
        prime: while () {
            my $p = $it->();
            next prime if exists $seen{$p};
            my @dig = todigits $p, $base;
            next prime if @dig < $minlen;
            for (1 .. @dig - 1) {
                @dig = @dig[1 .. $#dig, 0];
                my $pr = fromdigits \@dig, $base;
                next prime unless is_prime $pr;
                $seen{$pr} = undef;
            }
            yield $p;
        }
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        my $cpg = gen_circular_primes(10, 3);
        is [map $cpg->(), 1 .. 10],
            [113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933],
            'task 1';
    }

    SKIP: {
        skip "tests" unless $tests;
        
        my $cpg_10 = gen_circular_primes(10, 1);
        is [map $cpg_10->(), 1 .. 9],
            [2, 3, 5, 7, 11, 13, 17, 37, 79],
            'small circular primes';

        # Are there no other circular primes in base 2 besides Mersenne
        # primes?
        my $cpg_2 = gen_circular_primes(2, 1);
        is [map $cpg_2->(), 1 .. 7],
            [3, 7, 31, 127, 8191, 131071, 524287],
            'Mersenne primes';

        # A272106 is much stronger: every permutation of the ternary
        # digits gives a prime number.
        my $cpg_3 = gen_circular_primes(3, 1);
        is [map $cpg_3->(), 1 .. 5],
            [2, 5, 13, 1093, 797161],
            'OEIS A272106';
	}

    done_testing;
    exit;
}
