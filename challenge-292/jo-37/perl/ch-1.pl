#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

I...
    list of integers

EOS


### Input and Output

say twice_largest(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/08/ch-292.html#task-1


sub twice_largest {
    my $i = long @_;
    my $max2 = $i->maximum_n_ind(2);

    0 <= inner($i($max2), long(1, -2)) ? $max2((0)) : -1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is twice_largest(2, 4, 1, 0), 1, 'example 1';
        is twice_largest(1, 2, 3, 4), -1, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
    }

    done_testing;
    exit;
}
