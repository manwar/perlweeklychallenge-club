#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(fromdigits todigits);
use List::Gen;
use experimental qw(signatures);

our ($tests, $examples, $base);
$base //= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    print first N gapful numbers

EOS


### Input and Output

gen_gapful($base)->say(shift);


### Implementation

sub gen_gapful ($base) {
    my $start = $base**2;
	<$start..>->filter(sub {
            !($_ % fromdigits [(todigits $_, $base)[0, -1]], $base);
        });
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        is gen_gapful(10)->take(20), [100, 105, 108, 110, 120, 121, 130,
            132, 135, 140, 143, 150, 154, 160, 165, 170, 176, 180, 187,
            190], 'task 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
