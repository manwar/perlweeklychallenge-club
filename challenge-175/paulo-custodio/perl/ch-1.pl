#!/usr/bin/env perl

# Perl Weekly Challenge 175 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-175/

use Modern::Perl;
use DateTime;

sub last_sunday_month {
    my($year, $month) = @_;
    my $date = DateTime->last_day_of_month(year=>$year, month=>$month);
    $date->add(days=>-1) while $date->day_of_week() != 7;
    return $date;
}

sub last_sunday_year {
    my($year) = @_;
    return map {last_sunday_month($year, $_)} 1..12;
}

@ARGV==1 or die "usage: ch-1.pl year\n";
my $year = shift;
say $_->ymd for last_sunday_year($year);
