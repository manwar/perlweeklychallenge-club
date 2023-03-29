#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Gen;
use Math::Prime::Util qw(is_prime factor);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
   print attractive numbers up to N

EOS


### Input and Output

gen_attractive_numbers()->while("<= $ARGV[0]")->say;


### Implementation

sub gen_attractive_numbers {
	<2..>->filter(sub {is_prime(scalar factor($_))});
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gen_attractive_numbers()->while('<= 50')->apply,
        [4, 6, 8, 9, 10, 12, 14, 15, 18, 20, 21, 22, 25, 26, 27, 28, 30,
            32, 33, 34, 35, 38, 39, 42, 44, 45, 46, 48, 49, 50],
            'task 1 from OEIS A063989';
    }

    SKIP: {
        skip "tests" unless $tests;
        is gen_attractive_numbers()->take(63),
        [4, 6, 8, 9, 10, 12, 14, 15, 18, 20, 21, 22, 25, 26, 27, 28, 30,
            32, 33, 34, 35, 38, 39, 42, 44, 45, 46, 48, 49, 50, 51, 52,
            55, 57, 58, 62, 63, 65, 66, 68, 69, 70, 72, 74, 75, 76, 77,
            78, 80, 82, 85, 86, 87, 91, 92, 93, 94, 95, 98, 99, 102,
            105, 106],
            'first 63 from OEIS A063989';
	}

    done_testing;
    exit;
}
