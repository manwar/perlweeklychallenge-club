#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;

my $month = Time::Piece->strptime ('1900-01-01', '%Y-%m-%d');
while ($month->year < 2020) {
    printf "%s %i has 5 weekends\n", $month->fullmonth, $month->year
        if $month->month_last_day == 31 && $month->wday == 6;
    $month = $month->add_months (1);
}
