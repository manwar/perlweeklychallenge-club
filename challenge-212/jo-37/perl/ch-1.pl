#!/usr/bin/perl -s

use v5.20;
use Test2::V0;
use List::MoreUtils qw(zip6);
use experimental qw(signatures);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [WORD J1 J2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

WORD
    base word

J1 J2...
    jump steps for each letter in WORD

EOS


### Input and Output

say jump_letters(@ARGV);


### Implementation

sub jump_letters ($word, @jump) {
	join '', map {
        my $base = ord($_->[0] ge 'a' ? 'a' : 'A');
        chr($base + (ord($_->[0]) - $base + $_->[1]) % 26)
    } &zip6([split //, $word], \@jump);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is jump_letters('Perl', 2, 22, 19, 9), 'Raku', 'example 1';
        is jump_letters('Raku', 24, 4, 7, 17), 'Perl', 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
