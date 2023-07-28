#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Date::Manip::Recur;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1 && $ARGV[0] =~ /^\d{4}$/;
usage: $0 [-examples] [-tests] [-verbose] [YYYY]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

YYYY
    find all Friday 13th for the given year

EOS


### Input and Output

if ($verbose) {
    say $_->printf('%b') for friday_13th($ARGV[0]);
} else {
    say scalar friday_13th($ARGV[0]);
}


### Implementation

sub friday_13th ($year) {
    # Select the 13th day of every month, limit the result to Fridays and
    # apply this frequency to the given year.
    # For some strange reason this fails for 9998 and 9999, even if the
    # start and end dates are provided as valid Date::Manip::Date
    # objects.  Thus keeping it simple and just specify the (beginning
    # of the) year. 
    Date::Manip::Recur->new('0:1*0:13:0:0:0*IW5')->dates($year, $year + 1);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar(friday_13th(2023)), 2, 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        is scalar(friday_13th(1753)), 2, '1753 succeeds';
        is scalar(friday_13th(9997)), 1, '9997 succeeds';
        is scalar(friday_13th(9998)), 3, '9998 fails';
        is scalar(friday_13th(9999)), 1, '9999 fails';
	}

    done_testing;
    exit;
}
