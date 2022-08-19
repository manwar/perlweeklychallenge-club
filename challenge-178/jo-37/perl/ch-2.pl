#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use DateTime::Format::Strptime;
use DateTime::Format::Duration;
use experimental qw(signatures postderef);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [TIMESTAMP DURATION]

-examples
    run the examples from the challenge
 
-tests
    run some tests

TIMESTAMP
    base timestamp in format 'yyyy-mm-dd hh:mm'

DURATION
    duration in format 'hh:mm'

EOS


### Input and Output

say business_date(@ARGV);


### Implementation

sub business_date {
    # A 'yyyy-mm-dd hh:mm' DateTime formatter/parser.
    state $date_fmt = DateTime::Format::Strptime->new(pattern => '%F %R');

    # Business start and end hours per day of week.  These are stored as
    # durations that will be added to a DateTime object representing the
    # beginning of a day.  
    state $business = [
        # Mon - Fri
        ([map duration($_), qw(09:00 18:00)]) x 5,
        # Sat + Sun
        ([map duration($_), qw(0:00 0:00)]) x 2
    ];

    # Convert args from string to DateTime / Duration.
    my $timestamp = $date_fmt->parse_datetime(shift);
    my $duration = duration(shift);

    # The formatter will be propagated to the remaining DateTime
    # objects.
    $timestamp->set_formatter($date_fmt);

    while () {
        # Get the beginning of the day from the timestamp.
        my $day = $timestamp->clone->truncate(to => 'day');

        # Get the business starting and ending timestamps for the
        # current day of week. Mon is zero.
        my ($start, $end) = map $day + $_,
            $business->[$timestamp->day_of_week_0]->@*;

        # Adjust a timestamp prior to the business start.
        $timestamp = $start if $timestamp < $start;

        # We found the requested business hour if this day has business
        # hours and the duration is exhausted before the business end.
        # This covers an edge case: A timestamp after the business end
        # with a zero duration is delayed to the next business start.
        # See tests.
        return $timestamp + $duration
            if $start < $end && $timestamp + $duration <= $end;

        # Reduce the duration by todays remaining business hours.
        $duration->subtract_duration($end - $timestamp)
            if $timestamp <= $end;

        # Step to the next day.
        $timestamp = $day->add(days => 1);
    }
}

# Create a DateTime::Duration object from a string.
sub duration ($dur) {
    # A 'hh:mm' duration formatter/parser.
    state $dur_fmt = DateTime::Format::Duration->new(pattern => '%R');

    $dur_fmt->parse_duration($dur);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is business_date('2022-08-01 10:30', '4:00'),
        '2022-08-01 14:30', 'example 1';
        is business_date('2022-08-01 10:30', '4:00'),
        '2022-08-01 14:30', 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is business_date('2022-08-05 17:00', '11:00'),
        '2022-08-09 10:00', 'over the weekend';

        is business_date('2022-08-01 7:30', '1:00'),
        '2022-08-01 10:00', 'before business start';

        is business_date('2022-08-01 18:30', '1:00'),
        '2022-08-02 10:00', 'after business end';

        is business_date('2022-08-01 12:00', '45:00'),
        '2022-08-08 12:00', 'one business week';

        is business_date('2022-08-01 18:30','0:00'),
        '2022-08-02 09:00', 'edge case: zero duration after business end';

        is business_date('2022-08-01 08:30', '0:00'),
        '2022-08-01 09:00', 'edge case: zero duration before business start';

	}

    done_testing;
    exit;
}
