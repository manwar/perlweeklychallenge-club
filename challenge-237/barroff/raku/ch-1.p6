#!/usr/bin/env raku

use v6.d;

my subset Month of UInt where {not .defined or ($_ > 0 and $_ < 13)};
my subset WD    of UInt where {not .defined or ($_ > 0 and $_ < 6)};
my subset Dow   of UInt where {not .defined or ($_ > 0 and $_ < 8)};

sub size-the-day(UInt:D $year, Month:D $month , WD:D $wd, Dow:D $dow --> Int:D) {
    my Date $day = Date.new($year, $month, 1);
    my UInt $week-shift = $day.day-of-week > $dow ?? 1 !! 2;
    if $wd == 1 {
        return $week-shift == 1 ?? 0 !! 1 + $dow - $day.date-of-week;
    }
    my UInt $days = 7 - $day.day-of-week + ($wd - $week-shift) * 7 + $dow;
    my Date $final-day = $day.later(days => $days);
    return $final-day.month == $day.month ?? $final-day.day !! 0;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is size-the-day(2024,  4, 3, 2), 16, 'works for size-the-day(2024,  4, 3, 2)';
    is size-the-day(2025, 10, 2, 4), 9,  'works for size-the-day(2025, 10, 2, 4)';
    is size-the-day(2026,  8, 5, 3), 0,  'works for size-the-day(2026,  8, 5, 3)';
}

#| Take user provided year like 2023 4 3 2
multi sub MAIN(UInt:D $year, Month:D $month , WD:D $wd, Dow:D $dow) {
    say size-the-day($year, $month , $wd, $dow);
}
