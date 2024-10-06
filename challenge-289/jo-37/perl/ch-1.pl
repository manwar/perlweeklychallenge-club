#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use warnings FATAL => 'all';
use Data::Dump qw(dd pp);
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

I...
    list of integers

EOS


### Input and Output

say third_max(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/10/04/ch-289.html#task-1


sub third_max {
    my @max = ('-inf') x 3;
    n: for my $n (@_) {
        i: for my $i (0 .. 2) {
            if ($n == $max[$i]) {
                next n;
            } elsif ($n > $max[$i]) {
                splice(@max, $i, 0, $n);
                $#max = 2;
                last i;
            }
        }
    }

    $max[2] > '-inf' ? $max[2] : $max[0];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is third_max(5, 6, 4, 1), 4, 'example 1';
        is third_max(4, 5), 5, 'example 2';
        is third_max(1, 2, 2, 3), 1, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is third_max(1, 1, 2, 2, 3, 3, 4, 4), 2, 'all doubles';
        is third_max(3, 3, 4, 4), 4, 'no third';


	}

    done_testing;
    exit;
}
