#!/bin/env perl6

my $format = sub ($self) { sprintf '%04d/%02d/%02d', .year, .month, .day, given $self };

sub last-day-to-last-friday(Int $year, Int $month, Int $day) {
    my Date $d = Date.new(sprintf "%04d-%02d-%02d", $year, $month, $day);
    $d -= ($d.day-of-week - 5) mod 7;
}

sub MAIN(Int $year) {
    my @last-days = 31, Date.new(year => $year).is-leap-year ?? 29 !! 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31;
    (1 .. 12).map({ last-day-to-last-friday($year, $_, @last-days[$_ - 1]) })».clone(formatter => $format)».say;
}
