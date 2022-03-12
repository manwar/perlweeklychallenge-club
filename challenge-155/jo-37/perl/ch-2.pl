#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Coro::Generator;
use experimental qw(signatures smartmatch);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    Print the N-th Pisano period

EOS


### Input and Output

say pisano(shift);


### Implementation

# Build a generator for the Fibonacci sequence modulo N.
sub gen_fibonacci_mod ($n) {
    my ($f1, $f2) = (0, 1);

    # Returns the last two numbers at the current position in the
    # sequence.
    generator {
        while () {
            yield [($f1, $f2) = ($f2, ($f1 + $f2) % $n)];
        }
    }
}

# Retrieve numbers of the Fibonacci sequence modulo N until the starting
# pair reappears.
sub pisano ($n) {
    return 1 if $n == 1;
    my ($fm, $m, $f) = (gen_fibonacci_mod($n), 0);
    until (@$f ~~ @{[0, 1]}) {
        $m++;
        $f = $fm->();
    }

    $m;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is pisano(3), 8, 'task 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $fm = gen_fibonacci_mod(3);
        is [map $fm->()[0], 1 .. 10], [1, 1, 2, 0, 2, 2, 1, 0, 1, 1],
            'Fibonacci mod 3';

        is pisano(50), 300, 'from OEIS';
	}

    done_testing;
    exit;
}
