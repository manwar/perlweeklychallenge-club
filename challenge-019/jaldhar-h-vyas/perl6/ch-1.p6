#!/usr/bin/perl6

multi sub MAIN() {
    constant FRIDAY = 5;

    for 1900 .. 2019 -> $year {
        for 1 .. 12 -> $month {

            my $date = Date.new(year => $year, month => $month, day => 1,
                formatter => { sprintf("%02d/%d", .month, .year) }
            );

            if ($date.days-in-month == 31 && $date.day-of-week == FRIDAY) {
                say $date;
            }
        }
    }
}