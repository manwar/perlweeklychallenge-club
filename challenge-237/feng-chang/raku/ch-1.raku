#!/bin/env raku

unit sub MAIN(UInt:D $year, UInt:D $month, UInt:D $week-of-month, UInt:D $day-of-week);

my $month_ = $month.fmt('%02d');
my $dow01 = Date.new("{$year}-{$month_}-01").day-of-week;
my $target = 1 + ($day-of-week - $dow01 + 7) % 7 + 7 * ($week-of-month - 1);
put try {
    Date.new("{$year}-{$month_}-{$target.fmt('%02d')}");
} ?? $target !! 0;
