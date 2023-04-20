#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Math::Prime::Util qw(todigits fromdigits todigitstring);
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests
N
    find the smalles zero-one product of N

EOS


### Input and Output

say mult01(shift);


### Implementation

# Interpret the binary representation of a number as decimal.  This
# enumerates the possible products.
sub mult01 ($n) {
    my $i;
    0 while fromdigits([todigits ++$i, 2]) % $n;
    todigitstring($i, 2);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is mult01(55), 110, 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        is mult01(333), 111111111;
        is mult01(33333), 111111111111111;
	}

    done_testing;
    exit;
}
