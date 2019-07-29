#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Time::Piece;
use Time::Seconds;

my $date = 'Time::Piece'->strptime(
    '1900-01-01 12:00:00', '%Y-%m-%d %H:%M:%S');

while ($date->year < 2020) {
    $date += ONE_DAY until $date->day eq 'Fri';
    if ($date->mday == 1 && $date->month_last_day == 31) {
        say $date->strftime('%Y-%m');
    }
    $date += ($date->month_last_day - $date->mday + 1) * ONE_DAY;
}
