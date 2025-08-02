#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 1;
usage: $0 [-examples] [-tests] [K I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

K
    (positive) integer

I...
    list of integers

EOS


### Input and Output

say ced(@ARGV);


### Implementation

sub ced {
    my $k = shift;
	my $ints = long @_;
    my $i = sequence($ints);
    my $j = $i->dummy(0);

    which(($j > $i) & ($ints->dummy(0) == $ints) & ! ($i * $j % $k))->nelem;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is ced(2 ,=> 3,1,2,2,2,1,3), 4, 'example 1';
        is ced(1,2,3), 0, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
