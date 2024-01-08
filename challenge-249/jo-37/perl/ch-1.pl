#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say join ", ", map "(@$_)", equal_pairs(@ARGV);


### Implementation

# Count the frequencies of all given numbers, check if these are all
# even and build equal pairs.

sub equal_pairs {
	my %freq;
    $freq{$_}++ for @_;
    return () if grep $_ % 2, values %freq;

    map +([$_, $_]) x ($freq{$_} / 2), keys %freq;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [equal_pairs(3, 2, 3, 2, 2, 2)],
            bag {item [2, 2]; item [2, 2]; item [3, 3]; end;}, 'example 1';

        is [equal_pairs(1, 2, 3, 4)], [] , 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
