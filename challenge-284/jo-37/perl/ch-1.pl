#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL '2.017';
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of integers

EOS


### Input and Output

say lucky_integer(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/08/30/ch-284.html#task-1


sub lucky_integer {
    my ($freq, $val) = rle long(@_)->qsort;
    my $lucky = $val->where($freq == $val);
    $lucky->isempty ? -1 : $lucky(-1;-);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is lucky_integer(2, 2, 3, 4), 2, 'example 1';
        is lucky_integer(1, 2, 2, 3, 3, 3), 3, 'example 2';
        is lucky_integer(1, 1, 1, 3), -1, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is lucky_integer(
            qw(11 1 11 2 11 2 11 3 11 3 11 3 11 4 11 4 11 4 11 4 11)), 11,
            'these go to eleven';
	}

    done_testing;
    exit;
}
