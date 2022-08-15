#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Time::Piece;
use Time::Seconds qw{ ONE_HOUR ONE_DAY ONE_WEEK };

sub _move_to_business_hours ($tp) {
    $tp = 'Time::Piece'->strptime(
        $tp->strftime('%Y-%m-%d 9:00'), '%Y-%m-%d %H:%M')
        if $tp->hour < 9;

    $tp = 'Time::Piece'->strptime(
        $tp->strftime('%Y-%m-%d 9:00'), '%Y-%m-%d %H:%M')
        + ONE_DAY
        if $tp->hour >= 18;

    if (($tp->day_of_week || 7) > 5) {
        $tp = 'Time::Piece'->strptime(
            $tp->strftime('%Y-%m-%d 9:00'), '%Y-%m-%d %H:%M')
            + ONE_DAY * (8 - ($tp->day_of_week || 7));
    }
    return $tp
}

sub business_date ($timestamp, $duration) {
    my $tp = _move_to_business_hours(
        'Time::Piece'->strptime($timestamp, '%Y-%m-%d %H:%M'));

    my ($decimal) = $duration - int $duration;
    $duration = int $duration;

    my $weeks = int($duration / (9 * 5));
    $tp += ONE_WEEK * $weeks;
    $duration %= 9 * 5;

    my $days = int($duration / 9);
    $duration %= 9;
    $days += 2 if ($tp->day_of_week || 7) + $days > 5;
    $tp += ONE_DAY * $days;

    $duration += $decimal;

    $tp += ONE_HOUR * $duration;
    $tp += ONE_HOUR * 15 if $tp->hour >= 18 || $tp->hour < 9;
    $tp += ONE_DAY  *  2 if ($tp->day_of_week || 7) > 5;

    return $tp->strftime('%Y-%m-%d %H:%M')
}

use Test::More tests => 2 + 9;

is business_date('2022-08-01 10:30', 4),   '2022-08-01 14:30', 'Example 1';
is business_date('2022-08-01 17:00', 3.5), '2022-08-02 11:30', 'Example 2';

is business_date('2022-08-05 17:00', 2),    '2022-08-08 10:00', 'over weekend';
is business_date('2022-08-05 05:21', 2),    '2022-08-05 11:00', 'start early';
is business_date('2022-08-05 23:21', 2),    '2022-08-08 11:00', 'start late';
is business_date('2022-08-01 18:00', 0),    '2022-08-02 09:00', 'last sec';
is business_date('2022-08-06 17:00', 0),    '2022-08-08 09:00', 'from Saturday';
is business_date('2022-08-07 22:00', 1),    '2022-08-08 10:00', 'from Sunday';
is business_date('2022-08-06 03:00', 100),  '2022-08-23 10:00', '2 weeks+';
is business_date('2022-08-08 09:30', 8.75), '2022-08-09 09:15', 'almost 1 day';
is business_date('2022-08-08 17:00', 7),    '2022-08-09 15:00', 'over midnight';
