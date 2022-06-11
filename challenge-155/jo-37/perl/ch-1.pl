#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use bigint;
use Math::Prime::Util qw(next_prime is_prime);
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
    Print the first N distinct fortunate numbers in ascending order.

EOS


### Input and Output

main: {
    my $fn = gen_fortunate_numbers();
    my %fn;
    # Collect the first N distinct fortunate numbers.
    until (keys %fn == $ARGV[0]) {
        $fn{$fn->()} = undef;
    }
    # Present in ascending order.
    say for sort {$a <=> $b} keys %fn;
}


### Implementation

# Build a generator for fortunate numbers.  The resulting sequence is
# neither sorted nor does it consist of distinct values only.
sub gen_fortunate_numbers {
    my $pn = 1;
    my $p = 1;

    generator {
        while () {
            $pn *= ($p = next_prime($p));
            for (my $m = 2;; $m++) {
                yield($m), last if is_prime($pn + $m);
            }
        }
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $fn = gen_fortunate_numbers();
        is [map $fn->(), 1 .. 9], [3, 5, 7, 13, 23, 17, 19, 23, 37],
            'the raw sequence: neither sorted nor distinct'
    }

    SKIP: {
        skip "tests" unless $tests;

        my $fn = gen_fortunate_numbers();
        $fn->() for 1 .. 57;
        is $fn->(), 331, '#58 according to OEIS';
	}

    done_testing;
    exit;
}
