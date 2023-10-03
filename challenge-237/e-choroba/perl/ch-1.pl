#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Time::Piece;
use Time::Seconds qw{ ONE_DAY ONE_WEEK };

sub seize_the_day($year, $month, $weekday_of_month, $day_of_week) {
    return 0 if $weekday_of_month > 5;

    # In the input, 1 is Monday, 7 is Sunday.
    $day_of_week = ((1 + $day_of_week) % 7) || 7;

    my $tp = 'Time::Piece'->strptime(sprintf('%04d%02d%02d', $year, $month, 1),
                                     '%Y%m%d');
    my $weekday = $tp->wday;
    $tp += ONE_DAY * (($day_of_week - $weekday) % 7);  # The expected weekday.
    $tp += ONE_WEEK * ($weekday_of_month - 1);         # The expected week.
    return $tp->mon == $month ? $tp->mday : 0
}

use Test::More tests => 3 + 26;

is seize_the_day(2024, 4, 3, 2), 16,
    'Example 1 # The 3rd Tue of Apr 2024 is the 16th';
is seize_the_day(2025, 10, 2, 4), 9,
    'Example 2 # The 2nd Thu of Oct 2025 is the 9th';
is seize_the_day(2026, 8, 5, 3), 0,
    "Example 3 # There isn't a 5th Wed in Aug 2026";

is seize_the_day(2023, 1, 53, 1), 0, '53 weeks in a year';

is seize_the_day(2023, 10, 1, 1), 2, 'Mon Oct 2 2023';
is seize_the_day(2023, 10, 1, 2), 3, 'Tue Oct 3 2023';
is seize_the_day(2023, 10, 1, 3), 4, 'Tue Oct 4 2023';
is seize_the_day(2023, 10, 1, 4), 5, 'Tue Oct 5 2023';
is seize_the_day(2023, 10, 1, 5), 6, 'Tue Oct 6 2023';
is seize_the_day(2023, 10, 1, 6), 7, 'Tue Oct 7 2023';
is seize_the_day(2023, 10, 1, 7), 1, 'Sun Oct 1 2023';
is seize_the_day(2023, 10, 2, 1), 9, 'Mon Oct 9 2023';
is seize_the_day(2023, 10, 2, 7), 8, 'Sun Oct 8 2023';
is seize_the_day(2023, 10, 5, 1), 30, 'Mon Oct 30 2023';
is seize_the_day(2023, 10, 5, 2), 31, 'Tue Oct 31 2023';
is seize_the_day(2023, 10, 5, 7), 29, 'Sun Oct 29 2023';

is seize_the_day(2023, 12, 1, 1), 4, 'Mon Dec 4 2023';
is seize_the_day(2023, 12, 1, 2), 5, 'Tue Dec 5 2023';
is seize_the_day(2023, 12, 1, 3), 6, 'Wed Dec 6 2023';
is seize_the_day(2023, 12, 1, 4), 7, 'Thu Dec 7 2023';
is seize_the_day(2023, 12, 1, 5), 1, 'Fri Dec 1 2023';
is seize_the_day(2023, 12, 1, 6), 2, 'Sat Dec 2 2023';
is seize_the_day(2023, 12, 1, 7), 3, 'Sun Dec 3 2023';
is seize_the_day(2023, 12, 2, 1), 11, 'Mon Dec 11 2023';
is seize_the_day(2023, 12, 2, 5), 8, 'Fri Dec 8 2023';
is seize_the_day(2023, 12, 4, 4), 28, 'Thu Dec 28 2023';
is seize_the_day(2023, 12, 5, 6), 30, 'Sat Dec 30 2023';
is seize_the_day(2023, 12, 5, 7), 31, 'Sun Dec 31 2023';
is seize_the_day(2023, 12, 5, 1), 0, '4 Mondays in Dec 2023';
