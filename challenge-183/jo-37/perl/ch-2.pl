#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use DateTime::Format::Strptime;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [DATE_1 DATE_2]

-examples
    run the examples from the challenge
 
-tests
    run some tests

DATE_1 DATE_2
    Two dates in format YYYY-MM-DD with DATE_2 after DATE_1.

EOS


### Input and Output

main: {
    my ($y, $d) = date_diff_yd(@ARGV);
    local $, = ' ';
    # Suppress zero units and append plural "s".
    say map /^(?!0)(\d+)/ ? $_ . 's' x ($1 > 1) : (), "$y year", "$d day";

}


### Implementation

# DateTime::Duration does not offer a conversion between years and days
# and therefore it probably cannot be done at all in a consistent way.
# Trying anyway: Take the difference between the two dates in years,
# reduce the second date by this timespan and take the difference to the
# first date in Julian days gives results fitting to the examples.  Not
# surprisingly this produces strange results:
#
# date_diff_yd('2019-02-28', '2020-02-28') and
# date_diff_yd('2019-02-28', '2020-02-29') both give (1, 0).  Gotcha!
#
# date_diff_yd('2020-02-29', '2021-02-28') gives (0, 365), but
# date_diff_yd('2020-02-29', '2021-03-01') gives (1, 1). Gotcha!

use constant YMD => DateTime::Format::Strptime->new(pattern => '%F');

sub date_diff_yd ($d1, $d2) {
    my ($dt1, $dt2) = map YMD->parse_datetime($_), $d1, $d2;
    my $y = ($dt2 - $dt1)->in_units('years');

    ($y, $dt2->subtract(years => $y)->jd - $dt1->jd)

}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is [date_diff_yd('2019-02-10', '2022-11-01')],
            [3, 264], 'Example 1';
        is [date_diff_yd('2020-09-15', '2022-03-29')],
            [1, 195], 'Example 2';
        is [date_diff_yd('2019-12-31', '2020-01-01')],
            [0, 1], 'Example 3';
        is [date_diff_yd('2019-12-01', '2019-12-31')],
            [0, 30], 'Example 4';
        is [date_diff_yd('2019-12-31', '2020-12-31')],
            [1, 0], 'Example 5';
        is [date_diff_yd('2019-12-31', '2021-12-31')],
            [2, 0], 'Example 6';
        is [date_diff_yd('2020-09-15', '2021-09-16')],
            [1, 1], 'Example 7';
        is [date_diff_yd('2019-09-15', '2021-09-16')],
            [2, 1], 'Example 8';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [date_diff_yd('2019-02-28', '2020-02-28')], [1, 0], 'one year';
        # Fails with (1, 0):
        is [date_diff_yd('2019-02-28', '2020-02-29')], [1, 1],
            'one year and a day';
        is [date_diff_yd('2020-02-29', '2021-02-28')], [0, 365], '365 days';
        # Fails with (1, 1):
        is [date_diff_yd('2020-02-29', '2021-03-01')], [1, 0], '1 year';

	}

    done_testing;
    exit;
}
