#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    List of number to be searched for contiguous intervals.

EOS


### Input and Output

main: {
    local $, = ', ';
    local $" = ', ';
    say map "[@$_]", range_list(@ARGV);
}

### Implementation

sub range_list {
    # Collect contiguous intervals:
    my @int = (['-inf']);

    # If the current number is the successor of the current interval's
    # last seen element, take it as the new interval endpoint.  Start a
    # new interval otherwise.
    $_ == $int[-1][-1] + 1 ? $int[-1][1] = $_ : push @int, [$_] for @_;

    # Discard point-only intervals.
    grep @$_ > 1, @int;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [range_list(1, 3, 4, 5, 7)], [[3, 5]], 'example 1';
        is [range_list(1, 2, 3, 6, 7, 9)], [[1, 3], [6, 7]], 'example 2';
        is [range_list(0, 1, 2, 4, 5, 6, 8, 9)], [[0, 2], [4, 6], [8, 9]],
            'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
        is [range_list(0, 2, 4, 6, 8)], [], 'none';
	}

    done_testing;
    exit;
}
