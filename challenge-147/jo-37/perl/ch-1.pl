#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Math::Prime::Util qw(fromdigits todigits is_prime);
use experimental 'signatures';

our ($tests, $examples, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=B] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    use base B. Default: 10

N
    check if N is a left-truncatable prime in base B

EOS


### Input and Output

say 0 + !!is_truncatable_prime(shift, $base);


### Implementation

sub is_truncatable_prime ($p, $b) {
    my @p = todigits($p, $b);
    while (@p) {
        $p = fromdigits([@p], $b);
        return unless is_prime($p);
        shift @p;
    }
	1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok is_truncatable_prime(9137, 10), 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
        
        ok !is_truncatable_prime(15, 10), '15';
        ok  is_truncatable_prime(17, 10), '17';
        ok !is_truncatable_prime(19, 10), '19';
	}

    done_testing;
    exit;
}
