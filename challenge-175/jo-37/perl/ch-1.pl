#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use DateTime::Duration;
use DateTime::Format::Strptime;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [YEAR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

YEAR
    Print the date of each month's last Sunday in the given year.

EOS


### Input and Output

say for last_sundays(shift);


### Implementation

# <blockquote>
# `perl -ne 'print if 8..13' ../../../challenge-132/dave-jacoby/perl/ch-1.pl`
# </blockquote>

use constant MONTH =>
    DateTime::Duration->new(months => 1, end_of_month => 'preserve');

# YYYY-MM-DD
use constant YMD =>
    DateTime::Format::Strptime->new(pattern => '%F');

# Returns an array of DateTime objects.
sub last_sundays ($year) {
    # Get the end of January.
    my $jan31 = DateTime->new(
        year => $year, month => 1, day => 31, formatter => YMD);

    # For each month of the year, get the end day and go back to
    # the previous Sunday. (day_of_week for Sunday is 7)
    map $_->subtract(days => $_->day_of_week % 7),
        map $jan31 + $_ * MONTH, 0 .. 11;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [last_sundays(2022)],
        [qw(2022-01-30 2022-02-27 2022-03-27 2022-04-24 2022-05-29
            2022-06-26 2022-07-31 2022-08-28 2022-09-25 2022-10-30
            2022-11-27 2022-12-25)], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        is +(last_sundays(2004))[1]->day_of_month, 29, 'Sun Feb 29 2004';
	}

    done_testing;
    exit;
}
