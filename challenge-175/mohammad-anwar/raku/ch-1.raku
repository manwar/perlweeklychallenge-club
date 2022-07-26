#!/usr/bin/env raku

=begin pod

Week 175:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-175

Task #1: Last Sunday

    Write a script to list Last Sunday of every month in the given year.

=end pod

use Test;

my $got = all-last-sunday-of(2022);
my $exp = [
    '2022-01-30', '2022-02-27', '2022-03-27', '2022-04-24',
    '2022-05-29', '2022-06-26', '2022-07-31', '2022-08-28',
    '2022-09-25', '2022-10-30', '2022-11-27', '2022-12-25',
];

is $exp, $got;

done-testing;

#
#
# METHODS

sub all-last-sunday-of(Int $year where $year >= 1900) {
    my $ls = [];
    $ls.push: last-sunday-of($_, $year) for (1..12);
    return $ls;
}

sub last-sunday-of(Int $month where $month >= 1 && $month <= 12,
                   Int $year  where $year  >= 1900 --> Date) {
    my $dt  = Date.new($year, $month, 1).last-date-in-month;
    my $dow = $dt.day-of-week;
    $dt -= $dow if $dow != 7;

    return $dt;
}
