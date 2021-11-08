#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [time...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

time...
    calculate the smaller angle between hour and minute hands for the
    given time(s).

EOS


### Input and Output

say clock_angle($_) // "invalid time: $_" for @ARGV;


### Implementation

# To find the smaller angle between the hands we need a "double
# triangular" function in the range (-2m, 2m) with this shape:
#
# m     /\      /\
#      /  \    /  \
#     /    \  /    \
# 0  /      \/      \
#  -2m  -m  0   m   2m
#
# which is provided by: f(x) = m - abs(m - abs(x))
#
# The minute and hour hands move 6° and 0.5° per minute respectively,
# resulting in a difference of 5.5° per minute.

sub clock_angle ($time) {
    # The accepted time format is [H]H:MM.  Distinguishing between
    # invalid time strings and a zero degree angle.
    $time =~ /^([01]?\d|2[0-3]):([0-5]\d)$/ || undef and
        180 - abs 180 - abs $1 % 12 * 30 - 5.5 * $2;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is clock_angle('03:10'), 35, 'example 1';
        is clock_angle('04:00'), 120, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is clock_angle(12345), U(), 'not a valid time';
        is clock_angle('25:00'), U(), 'not a valid hour';
        is clock_angle('23:60'), U(), 'not a valid minute';
        is clock_angle('0:00'), 0, 'omit leading zero';
        is clock_angle('12:00'), 0, 'zero degrees';
        is clock_angle('5:00'), 150, 'min to hour';
        is clock_angle('7:00'), 150, 'hour to min';
        # The smallest angles besides noon and midnight:
        is clock_angle($_), 0.5, $_ for (qw(2:11 9:49 14:11 21:49));
	}

    done_testing;
    exit;
}
