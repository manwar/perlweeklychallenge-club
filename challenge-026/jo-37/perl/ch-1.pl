#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use warnings FATAL => 'all';
use Data::Dump qw(dd pp);
use experimental qw(signatures postderef);

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [STONES JEWELS]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STONES JEWELS
    count alphabet from STONES in JEWELS

EOS


### Input and Output

say count_alphabet(@ARGV);


### Implementation

sub count_alphabet ($stones, $jewels) {
    my %jewels;
    @jewels{split //, $jewels} = (1) x length($jewels);
    scalar grep $_, @jewels{split //, $stones};
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_alphabet("chancellor", "chocolate"), 8, 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
