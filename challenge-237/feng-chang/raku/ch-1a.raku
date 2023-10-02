#!/bin/env raku

unit sub MAIN(UInt:D $year, UInt:D $month, UInt:D $week-of-month, UInt:D $day-of-week);

put (1..31).grep({ Date.new("{$year}-{$month.fmt('%02d')}-{.fmt('%02d')}").day-of-week == $day-of-week })[$week-of-month - 1] // 0;
