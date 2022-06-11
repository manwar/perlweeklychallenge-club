#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Coro::Generator;
use Math::Prime::Util qw(lucasu todigits vecsum);

our ($examples, $base);
$base ||= 10;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=B] [N]

-examples
    run the examples from the challenge
 
-base=B
    consider numbers in base B. Default: 10

N
    Print the first N numbers having a digit sum in base B that is a
    Fibonacci number.

EOS


### Input and Output

{
    my $fib_digsum_seq = gen_fib_digsum_seq();
    say $fib_digsum_seq->() for 1 .. shift;
}


### Implementation

sub gen_fib_digsum_seq {
    # Considering only numbers with a digit sum less than 233.
    state $fib = {map +(lucasu(1, -1, $_) => undef), 0 .. 12};

    # Build a generator for numbers having a digit sum that is a
    # Fibonacci number.
    generator {
        for (my $k = 0;; $k++) {
            yield $k if exists $fib->{vecsum(todigits $k, $base)};
        }
    }
}


### Examples and tests

sub run_tests {

    my $fib_digsum_seq = gen_fib_digsum_seq();
    is [map $fib_digsum_seq->(), 1 .. 20],
        [qw(0 1 2 3 5 8 10 11 12 14 17 20 21 23 26 30 32 35 41 44)],
        'example 1';

    done_testing;
    exit;
}
