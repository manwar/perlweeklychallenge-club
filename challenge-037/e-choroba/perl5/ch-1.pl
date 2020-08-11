#!/usr/bin/perl
use warnings;
use strict;

use Time::Piece;
use Time::Seconds qw{ ONE_DAY };

sub days_in_month {
    my ($month) = @_;
    my $date = 'Time::Piece'->strptime("2019 $month 1 12:00",
                                       '%Y %b %d %H:%M');
    my $count = 0;
    while ($date->month eq $month) {
        ++$count unless grep $date->day eq $_, qw( Sat Sun );
        $date += ONE_DAY;
    }
    return $count
}

use Test::More tests => 12;

is days_in_month('Jan'), 23, 'Jan';
is days_in_month('Feb'), 20, 'Feb';
is days_in_month('Mar'), 21, 'Mar';
is days_in_month('Apr'), 22, 'Apr';
is days_in_month('May'), 23, 'May';
is days_in_month('Jun'), 20, 'Jun';
is days_in_month('Jul'), 23, 'Jul';
is days_in_month('Aug'), 22, 'Aug';
is days_in_month('Sep'), 21, 'Sep';
is days_in_month('Oct'), 23, 'Oct';
is days_in_month('Nov'), 21, 'Nov';
is days_in_month('Dec'), 22, 'Dec';
