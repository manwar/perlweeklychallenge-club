#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(factor_exp vecmax);
use Coro::Generator;

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [N]

-examples
    run the examples from the challenge

N
    Print first N square-free integers.

EOS


### Input and Output

main: {
    my $sq_free = gen_square_free();
    say $sq_free->() for 1 .. $ARGV[0];
}


### Implementation

# Build a generator for square-free integers.
sub gen_square_free {
    generator {
        # Treat 1 separately as factor(1) returns an empty list.
        yield 1;
        for (my $n = 2;; $n++) {
            # Check if the maximum exponent in N's factorization is one.
            yield $n if 1 == vecmax map $_->[1], factor_exp $n;
        }
    }
}


### Examples and tests

sub run_tests {
    my $sq_free = gen_square_free();
    is [map $sq_free->(), 1 .. 19],
        [1, 2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 30],
        'example 1';

    done_testing;
    exit;
}
