#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(is_prime next_prime);
use List::Gen;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    print the first N "sexy prime pairs"

EOS


### Input and Output

sexy_prime_pairs()->map(sub {"(@$_)"})->say(shift);


### Implementation

sub sexy_prime_pairs {
    iterate(sub {next_prime($_)})
    ->from(2)
    ->filter(sub {is_prime($_ + 6)})
    ->map(sub {[$_, $_ + 6]});
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is sexy_prime_pairs()->while(sub {$_->[1] < 500})->apply,
        [[5,11], [7,13], [11,17], [13,19], [17,23], [23,29], [31,37],
            [37,43], [41,47], [47,53], [53,59], [61,67], [67,73],
            [73,79], [83,89], [97,103], [101,107], [103,109], [107,113],
            [131,137], [151,157], [157,163], [167,173], [173,179],
            [191,197], [193,199], [223,229], [227,233], [233,239],
            [251,257], [257,263], [263,269], [271,277], [277,283],
            [307,313], [311,317], [331,337], [347,353], [353,359],
            [367,373], [373,379], [383,389], [433,439], [443,449],
            [457,463], [461,467]],
        'example from Wiki';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
