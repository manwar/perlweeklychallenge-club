#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Unicode::Normalize;
use List::Util qw(reduce);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    a string

EOS


### Input and Output

say gl(shift);


### Implementation

sub gl {
    my %l;
    uc reduce {
        local $_ = $b;
        my $fc = fc;
        ($l{$fc} |= /\p{Ll}/ | /\p{Lu}/ << 1) == 3 && $fc gt $a ?
            $fc :
            $a;
    } '', split //, NFC shift;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gl('PeRlwEeKLy'), 'L', 'example 1';
        is gl('ChaLlenge'), 'L', 'example 2';
        is gl('The'), '', 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
        is gl('Über über'), 'Ü', 'umlaut';
        is gl('123 abc 123'), '', 'ignore non-letters';
	}

    done_testing;
    exit;
}
