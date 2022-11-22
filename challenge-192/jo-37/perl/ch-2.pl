#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util qw(reduce reductions);

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    non-negative integers

EOS


### Input and Output

say num_moves(@ARGV);


### Implementation

# See the blog
# https://github.com/jo-37/perlweeklychallenge-club/blob/master/challenge-192/jo-37/blog.pdf
# for a derivation of the formula behind this implementation.

sub num_moves {
    my @cum = reductions {$a + $b} @_;
    return -1 if $cum[-1] % @_;
    my ($eq, $step) = (0, $cum[-1] / @_);

    reduce {$a + abs($b - ($eq += $step))} 0, @cum;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is num_moves(1, 0, 5), 4, 'Example 1';
        is num_moves(0, 2, 0), -1, 'Example 2';
        is num_moves(0, 3, 0), 2, 'Example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is num_moves(1, 2, 3, 4, 5, 6, 7), 28, 'counted by hand';
        is num_moves(5, 5, 5, 5, 5), 0, 'equilibrium';
        is num_moves(5, 0, 0, 0, 0), 10, '4 + 3 + 2 + 1';
	}

    done_testing;
    exit;
}
