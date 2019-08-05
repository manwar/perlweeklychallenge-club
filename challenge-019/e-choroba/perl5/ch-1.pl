#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Time::Piece;
use Time::Seconds;

my $date = 'Time::Piece'->strptime(
    '1900-01-01 12:00:00', '%Y-%m-%d %H:%M:%S');

while ($date->year < 2020) {
    next if $date->day ne 'Fri';

    say $date->strftime('%Y-%m') if $date->month_last_day == 31;

} continue {
    $date += $date->month_last_day * ONE_DAY;
}
