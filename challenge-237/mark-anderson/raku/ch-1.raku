#!/usr/bin/env raku
use lib '.';
use WDOM;
use Test;

is seize-the-day(2024,  4, 3, 2), 16;
is seize-the-day(2025, 10, 2, 4),  9;
is seize-the-day(2026,  8, 5, 3),  0;

sub seize-the-day($year, $month, $weekday-of-month, $day-of-week)
{
    quietly + try WDOM.new(:$weekday-of-month, :$day-of-week, :$month, :$year).day 
}
