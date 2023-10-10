#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use Math::Prime::Util qw(todigits vecprod);

our ($tests, $examples, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=B] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    use base B for step calculation. Default: 10

N...
    list of numbers

EOS


### Input and Output

say "(@{persistence_sort($base, @ARGV)})";


### Implementation

# Generalizing the task to an arbitrary base.
# A "Schwartzian transform" that calculates the steps for each number
# only once in the sort process is useful for this task: First build a
# 2xN piddle consisting of pairs [steps, number], then perform a vector
# sort on this data and finally return the second column - the numbers
# itself.

sub persistence_sort {
    my $base = shift;

    long(
        map {
            my $steps = 0;
            for (my $n = $_; $n >= $base; $n = vecprod todigits $n, $base) {
                $steps++;
            }
            [$steps, $_];
        } @_
    )->qsortvec->((1))->unpdl;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is persistence_sort(10, 15, 99, 1, 34), [1, 15, 34, 99], 'example 1';
        is persistence_sort(10, 50, 25, 33, 22), [22, 33, 50, 25], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is persistence_sort(3, 3, 8, 9), [3, 9, 8], 'ternary';
        is persistence_sort(10, 796, 8222, 9111), [9111, 8222, 796], 'reverse';
	}

    done_testing;
    exit;
}
