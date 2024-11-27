#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';;
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

say +(qw(false true))[double_exist(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/08/ch-290.html#task-1


sub double_exist {
    my $ints = long @_;
    my $di = whichND $ints == 2 * $ints->dummy(0);

    any $di(0) != $di(1);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  double_exist(6, 2, 3, 3), 'example 1';
        ok !double_exist(3, 1, 4, 13), 'example 2';
        ok  double_exist(2, 1, 4, 2), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok !double_exist(0, 1, 3), 'exclude zero with itself';
        ok  double_exist(0, 1, 3, 0), 'include zero with another';
    }

    done_testing;
    exit;
}
