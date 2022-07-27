#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Time::Piece;
use Time::Seconds qw{ ONE_DAY };

sub last_sunday ($year) {
    my @dates;
    for my $month ('01' .. '12') {
        my $date = 'Time::Piece'->strptime("$year $month 01", '%Y %m %d');
        my $day = $date->month_last_day - 7;
        $date += $day * ONE_DAY;
        $date += ONE_DAY until $date->day eq 'Sun';
        push @dates, $date->ymd;
    }
    return \@dates
}

use Test2::V0;
plan 121 * 12 * 3 + 1;

for my $year (1900 .. 2020) {
    my $dates = last_sunday($year);
    for my $i (0 .. $#$dates) {
        my $date = $dates->[$i];
        my $tp = 'Time::Piece'->strptime($date, '%Y-%m-%d');
        is $tp->day, 'Sun';
        is $tp->_mon, $i;
        cmp_ok($tp->mday + 7, '>', $tp->month_last_day);
    }
}

is last_sunday(2022), [qw[ 2022-01-30 2022-02-27 2022-03-27 2022-04-24
                           2022-05-29 2022-06-26 2022-07-31 2022-08-28
                           2022-09-25 2022-10-30 2022-11-27 2022-12-25 ]];
