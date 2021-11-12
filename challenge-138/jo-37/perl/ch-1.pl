#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use DateTime;
use experimental 'signatures';
# For testing only:
use DateTime::Duration;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [Y]

-examples
    run the examples from the challenge
 
-tests
    run some tests

Y
    Count workday in year Y.

EOS


### Input and Output

# Count workdays between Jan 1 of the given year and the next.
say workdays_int(DateTime->new(year => $ARGV[0]),
    DateTime->new(year => $ARGV[0] + 1));
    

### Implementation

# Find the number of workdays in the interval from $start to (not
# including) $end.  Expecting DateTime arguments.
sub workdays_int ($start, $end) {
    return 0 if $start >= $end;
    my $days = $end->delta_days($start)->in_units('days');
    # Sat is 5, Sun is 6.
    my $dow = $start->day_of_week_0;

    # Every full week has 5 workdays.  From the remaining days count
    # working days only.
    5 * int($days / 7) + grep abs($dow + $_ - 5.5) > 1, 0 .. $days % 7 - 1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is workdays_int(DateTime->new(year => 2021),
            DateTime->new(year => 2022)), 261, 'example 1';
        is workdays_int(DateTime->new(year => 2020),
            DateTime->new(year => 2021)), 262, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        
        my $m = DateTime->new(
            year => 2021,
            month => 11,
            day => 8); # Challenge 138 published on Mon
        my $d = DateTime::Duration->new(days => 1);
        is workdays_int($m, $m), 0, 'same day';
        is workdays_int($m, $m + 4*$d), 4, 'Mon to Fri';
        is workdays_int($m, $m + 5*$d), 5, 'Mon to Sat';
        is workdays_int($m, $m + 6*$d), 5, 'Mon to Sun';
        is workdays_int($m + 3*$d, $m + 17*$d), 10, 'two full weeks';
        is workdays_int($m + 3*$d, $m + 5*$d), 2, 'Thu to Sat';
        is workdays_int($m + 3*$d, $m + 6*$d), 2, 'Thu to Sun';
        is workdays_int($m + 3*$d, $m + 7*$d), 2, 'Thu to Mon';
        is workdays_int($m + 4*$d, $m + 5*$d), 1, 'Fri to Sat';
        is workdays_int($m + 4*$d, $m + 6*$d), 1, 'Fri to Sun';
        is workdays_int($m + 4*$d, $m + 7*$d), 1, 'Fri to Mon';
        is workdays_int($m + 5*$d, $m + 7*$d), 0, 'Sat to Mon';
        is workdays_int($m + 6*$d, $m + 7*$d), 0, 'Sun to Mon';
        is workdays_int($m + 6*$d, $m + 12*$d), 5, 'Sun to Sat';
        is workdays_int($m + $d, $m), 0, 'end before start';
	}

    done_testing;
    exit;
}
