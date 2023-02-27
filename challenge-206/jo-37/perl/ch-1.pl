#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 1;
usage: $0 [-examples] [-tests] [H1:M1 H2:M2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

H1:M1 H2:M2...
    list of times in 24h-format HH:MM.

EOS


### Input and Output

say shortest_time(@ARGV);


### Implementation

sub shortest_time {
    # Parse times, calculate minutes, convert to "long" piddle and sort.
	my $times = long(map {/^(\d{2}):(\d{2})$/ ? 60 * $1 + $2 : ()} @_)->qsort;
    # Take the minimum over the difference of cyclic consecutive time
    # pairs modulo one day.
    min +($times->rotate(-1) - $times) % 1440;


}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is shortest_time("00:00", "23:55", "20:00"), 5, 'example 1';
        is shortest_time("01:01", "00:50", "00:57"), 4, 'example 2';
        is shortest_time("10:10", "09:30", "09:00", "09:55"), 15, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is shortest_time(qw(23:00 18:00 01:00)), 120, 'carry minimum over';
	}

    done_testing;
    exit;
}
