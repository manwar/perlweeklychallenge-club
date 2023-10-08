#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Date::Manip::Recur;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 4;
usage: $0 [-examples] [-tests] [YEAR MONTH NTH DOW]

-examples
    run the examples from the challenge
 
-tests
    run some tests

YEAR MONTH NTH DOW
    find the day of month for the n-th occurence of the given day of
    week in year and month.

EOS


### Input and Output

say seize_the_day(@ARGV);


### Implementation

# Though the primary use of Date::Manip::Recur is the specification of
# recurring events, it provides a concise description of single events,
# too.  In the context of this task it is "the n-th occurrence of a
# specific weekday in a given year and month".  There is one such event
# at most, where we pick the day of month from, if it exists.
sub seize_the_day {
    local $" = ':';
	my ($date) = Date::Manip::Recur->new("*@_:0:0:0")->dates;
    $date ? ($date->value)[2] : 0;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is seize_the_day(2024, 4, 3, 2), 16, 'example 1';
        is seize_the_day(2025, 10, 2, 4), 9, 'example 2';
        is seize_the_day(2026, 8, 5, 3), 0, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is seize_the_day(2023, 6, 1, 3), 7, '2023-06-07';
	}

    done_testing;
    exit;
}
