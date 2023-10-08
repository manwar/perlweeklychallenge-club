#!/usr/bin/env raku

sub seize-the-day ($year, $month, $weekday-of-month, $day-of-week) {
    Date.new: :$year, :$month
    andthen $_ ..^ .later: :1month
    andthen .grep: { .day-of-week == $day-of-week }\
    andthen .[$weekday-of-month-1]
    andthen .day
}

multi MAIN (Bool :test($)!) {
    use Test;
    is seize-the-day(2024,4,3,2),16;
    is seize-the-day(2025,10,2,4),9;
    is-deeply seize-the-day(2026,8,5,3),Empty;
    done-testing;
}

multi MAIN ($year, $month, $weekday-of-month, $day-of-wee) {
    say +seize-the-day $year, $month, $weekday-of-month, $day-of-wee
}
