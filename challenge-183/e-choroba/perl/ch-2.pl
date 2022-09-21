#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Time::Piece;
use Time::Seconds qw{ ONE_DAY };

sub date_difference ($date1, $date2) {
    my ($d1, $d2) = map 'Time::Piece'->strptime($_, '%Y-%m-%d'), $date1, $date2;

    my $years = $d2->year - $d1->year;
    --$years if $d2->mon < $d1->mon
             || (   $d2->mon == $d1->mon
                 && $d2->mday < $d1->mday);

    my $d = 'Time::Piece'->strptime(join('-', $d1->year + $years,
                                              $d1->mon,
                                              $d1->mday), '%Y-%m-%d');
    my $days = int(($d2 - $d) / ONE_DAY);
    $days += 365 + $d2->is_leap_year if $days < 0;

    return to_english($years, $days)
}

sub to_english ($years, $days) {
    my $s = "";
    $s = $years . ' year' . ($years > 1 ? 's' : "") if $years;
    $s .= ($s ? ' ' : "") . $days . ' day'  . ($days  > 1 ? 's' : "") if $days;
    return $s || '0 days'
}

use Test::More tests => 8 + 9;

is date_difference('2019-02-10', '2022-11-01'), '3 years 264 days', 'Example 1';
is date_difference('2020-09-15', '2022-03-29'), '1 year 195 days', 'Example 2';
is date_difference('2019-12-31', '2020-01-01'), '1 day', 'Example 3';
is date_difference('2019-12-01', '2019-12-31'), '30 days', 'Example 4';
is date_difference('2019-12-31', '2020-12-31'), '1 year', 'Example 5';
is date_difference('2019-12-31', '2021-12-31'), '2 years', 'Example 6';
is date_difference('2020-09-15', '2021-09-16'), '1 year 1 day', 'Example 7';
is date_difference('2019-09-15', '2021-09-16'), '2 years 1 day', 'Example 8';

is date_difference('2019-09-15', '2019-09-15'), '0 days', 'Zero';
# Is this how humans understand time?
is date_difference('2019-02-28', '2020-03-01'), '1 year 2 days', 'Leap year';
is date_difference('2020-02-28', '2021-03-01'), '1 year 1 day', 'Non-leap year';
is date_difference('2020-02-28', '2021-01-01'), '308 days', 'Leap year';
is date_difference('2021-02-28', '2022-01-01'), '307 days', 'Non-leap year';
is date_difference('2019-02-28', '2020-02-29'), '1 year 1 day', 'Leap year';
is date_difference('2020-02-29', '2021-02-28'), '365 days', 'Leap year';
# These two are super weird!
is date_difference('2020-02-29', '2021-03-01'), '1 year', 'Leap year';
is date_difference('2020-03-01', '2021-03-01'), '1 year', 'Leap year, too';
