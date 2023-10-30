#! /usr/bin/raku

use Test;

plan 3;

is(seizetheday(2024, 4, 3, 2), 16, 'example 1');
is(seizetheday(2025, 10, 2, 4), 9, 'example 2');
is(seizetheday(2026, 8, 5, 3), 0, 'example 3');

sub seizetheday($year, $month, $weekcount, $dayofweek) {
    my $dt = Date.new(year => $year,
                      month => $month,
                      day => 1);
    my $wd = $dt.day-of-week;
    if ($wd != $dayofweek) {
        $dt = $dt.later(days => ($dayofweek - $wd + 7) % 7);
    }
    if ($weekcount > 1) {
        $dt = $dt.later(weeks => ($weekcount - 1));
    }
    if ($dt.month != $month || $dt.year != $year) {
        return 0;
    }
    return $dt.day;
}
