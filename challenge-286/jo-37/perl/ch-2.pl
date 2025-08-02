#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [--] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print intermediate results

I...
    list of integers

EOS


### Input and Output

say order_game(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/09/13/ch-286.html#task-2


sub order_game (@ints) {
    my $f = 1;
    say "@ints" if $verbose;
    while (@ints > 1) {
        my ($i, $k) = splice @ints, 0, 2;
        push @ints, ($f *= -1) * ($k - $i) > 0 ? $k : $i;
        say "@ints" if $verbose;
    }
    shift @ints;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is order_game(2, 1, 4, 5, 6, 3, 0, 2), 1, 'example 1';
        is order_game(0, 5, 3, 2), 0, 'example 2';
        is order_game(9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8),
            2, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is order_game(3, 2, 1), 2, 'not a power of two';

	}

    done_testing;
    exit;
}
